#!/usr/bin/env python3
"""Build data.sql and data_corrected_character_casing.sql from the INS SIRUTA archive.

    python tools/build.py                     newest archive in source/
    python tools/build.py path/to/SIRUTA.rar  a given archive, folder, .xls or .mdb file
    python tools/build.py --check             do not write, only compare with the files in the repo
    python tools/build.py --update-sql FILE   also write the SQL for the differences from the current data

The INS table is read from SIRUTA.xls (needs the "xlrd" package). When the archive has no
SIRUTA.xls (the older ones), or with --from mdb, it is read from the "siruta_rez" table of
siruta.mdb (needs mdbtools, or Docker).
The name corrections are in tools/corrections.csv.
"""
import argparse
import csv
import io
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CORRECTIONS = Path(__file__).resolve().parent / 'corrections.csv'
UPPER_FILE = 'data.sql'
TITLE_FILE = 'data_corrected_character_casing.sql'
COUNTIES = '`#__romanian_counties`'
LOCATIONS = '`#__romanian_locations`'

# Official two-letter county abbreviations, by INS county code.
ABBR = {
    1: 'AB', 2: 'AR', 3: 'AG', 4: 'BC', 5: 'BH', 6: 'BN', 7: 'BT', 8: 'BV', 9: 'BR', 10: 'BZ',
    11: 'CS', 12: 'CJ', 13: 'CT', 14: 'CV', 15: 'DB', 16: 'DJ', 17: 'GL', 18: 'GJ', 19: 'HR', 20: 'HD',
    21: 'IL', 22: 'IS', 23: 'IF', 24: 'MM', 25: 'MH', 26: 'MS', 27: 'NT', 28: 'OT', 29: 'PH', 30: 'SM',
    31: 'SJ', 32: 'SB', 33: 'SV', 34: 'TR', 35: 'TM', 36: 'TL', 37: 'VS', 38: 'VL', 39: 'VN', 40: 'B',
    51: 'CL', 52: 'GR',
}
BUCHAREST = 40
ALPHABET = ' -.0123456789AĂÂBCDEFGHIÎJKLMNOPQRSȘTȚUVWXYZ'
LOWER_WORDS = {'DE', 'DIN', 'LUI', 'CEL', 'CU', 'PE', 'SUB', 'LA', 'ÎN'}
ROMAN = {'I', 'II', 'III', 'IV', 'V', 'VI'}
PREFIX = re.compile(r'^(JUDEȚUL|MUNICIPIUL|ORAȘ)\s+')
ROW = re.compile(r"^\((\d+), (\d+), (\d+), '(.*)', (\d+), '(.*)'\)[,;]$", re.M)


def clean(name):
    """Correct Romanian letters, one space between words, a space after the dots of initials."""
    name = name.replace('Ş', 'Ș').replace('Ţ', 'Ț').replace('ş', 'ș').replace('ţ', 'ț')
    name = re.sub(r'\.(?=\S)', '. ', name)
    return re.sub(r'\s+', ' ', name).strip().upper()


def title(name):
    out, first = [], True
    for part in re.split(r'([ \-])', name):
        if part in ('', ' ', '-'):
            out.append(part)
            continue
        if not first and part in ROMAN:
            out.append(part)
        elif not first and part in LOWER_WORDS:
            out.append(part.lower())
        else:
            out.append(part[:1] + part[1:].lower())
        first = False
    return ''.join(out)


def romanian_order(name):
    return [ALPHABET.index(c) for c in name]


# ---------------------------------------------------------------- reading the INS file

def find_extractor():
    for exe in ('7z', '7zz', '7za'):
        path = shutil.which(exe)
        if path:
            return [path, 'x', '-y', '-bso0', '-bsp0'], '-o'
    for folder in (os.environ.get('ProgramFiles'), os.environ.get('ProgramFiles(x86)')):
        if folder and (Path(folder) / '7-Zip' / '7z.exe').exists():
            return [str(Path(folder) / '7-Zip' / '7z.exe'), 'x', '-y', '-bso0', '-bsp0'], '-o'
    path = shutil.which('unrar')
    if path:
        return [path, 'x', '-y', '-inul'], ''
    tars = [shutil.which('bsdtar'), shutil.which('tar')]
    if os.environ.get('SystemRoot'):
        tars.append(str(Path(os.environ['SystemRoot']) / 'System32' / 'tar.exe'))
    for path in tars:
        if path and Path(path).exists():
            version = subprocess.run([path, '--version'], capture_output=True, text=True).stdout
            if 'bsdtar' in version:
                return [path, '-xf'], '-C'
    sys.exit('No tool found to unpack the archive. Install 7-Zip, unrar or bsdtar, '
             'or unpack it by hand and give the folder as argument.')


def unpack(archive, folder):
    command, flag = find_extractor()
    if flag == '-o':
        command += [str(archive), '-o' + str(folder)]
    elif flag == '-C':
        command += [str(archive), '-C', str(folder)]
    else:
        command += [str(archive), str(folder) + os.sep]
    subprocess.run(command, check=True)


def newest_archive():
    found = []
    for path in (ROOT / 'source').glob('SIRUTA_*'):
        m = re.search(r'S(\d)_(\d{4})', path.name)
        if m:
            found.append((int(m[2]), int(m[1]), path))
    if not found:
        sys.exit('No SIRUTA archive in source/. Give the archive as argument.')
    return max(found)[2]


def find_file(folder, name, required=True):
    for path in sorted(Path(folder).rglob('*')):
        if path.name.lower() == name:
            return path
    if required:
        sys.exit(f'{name} not found in the source')


def read_xls(path):
    try:
        import xlrd
    except ImportError:
        sys.exit('The "xlrd" package is missing: pip install -r tools/requirements.txt')
    sheet = xlrd.open_workbook(str(path)).sheet_by_index(0)
    header = [str(v).strip().upper() for v in sheet.row_values(0)]
    return [dict(zip(header, sheet.row_values(i))) for i in range(1, sheet.nrows)]


def read_mdb(path):
    path = Path(path).resolve()
    if shutil.which('mdb-export'):
        command = ['mdb-export', str(path), 'siruta_rez']
    elif shutil.which('docker'):
        command = ['docker', 'run', '--rm', '-v', f'{path.parent}:/in:ro', 'alpine:3.20', 'sh', '-c',
                   f'apk add -q mdbtools-utils >/dev/null 2>&1 && mdb-export "/in/{path.name}" siruta_rez']
    else:
        sys.exit('Reading the .mdb file needs mdbtools (mdb-export) or Docker.')
    env = dict(os.environ, MSYS_NO_PATHCONV='1')
    result = subprocess.run(command, capture_output=True, env=env)
    if result.returncode:
        error = result.stderr.decode('utf-8', 'replace').strip()
        sys.exit(f'{command[0]} failed (is it running?). The error:\n{error}')
    text = result.stdout.decode('utf-8')
    return [{k.upper(): v for k, v in row.items()} for row in csv.DictReader(io.StringIO(text))]


def read_ins(source, kind):
    """Return (rows, description). A row is a dict with SIRUTA, DENLOC, JUD, SIRSUP and NIV."""
    source = Path(source)
    with tempfile.TemporaryDirectory() as tmp:
        if source.is_file() and source.suffix.lower() in ('.xls', '.mdb'):
            kind, path = source.suffix.lower()[1:], source
        else:
            if source.is_file():
                unpack(source, tmp)
                source_folder = tmp
            else:
                source_folder = source
            path = find_file(source_folder, 'siruta.xls', required=kind == 'xls') if kind != 'mdb' else None
            kind = 'xls' if path else 'mdb'
            path = path or find_file(source_folder, 'siruta.mdb')
        raw = read_xls(path) if kind == 'xls' else read_mdb(path)
        where = f'{source.name} > {path.name}' if path != source else path.name
    rows = []
    for r in raw:
        if str(r.get('SIRUTA', '')).strip() == '':
            continue
        rows.append({
            'siruta': int(float(r['SIRUTA'])),
            'name': clean(str(r['DENLOC'])),
            'county': int(float(r['JUD'])),
            'parent': int(float(r['SIRSUP'])),
            'level': int(float(r['NIV'])),
        })
    return rows, where


# ---------------------------------------------------------------- building the data

def load_corrections():
    with open(CORRECTIONS, encoding='utf-8', newline='') as f:
        return [dict(r, siruta=int(r['siruta'])) for r in csv.DictReader(f)]


def build(rows, corrections, report):
    names = {r['siruta']: PREFIX.sub('', r['name']) for r in rows}
    if len(names) != len(rows):
        sys.exit('ERROR: the INS file has a SIRUTA code more than once')
    applied = 0
    for c in corrections:
        ins = names.get(c['siruta'])
        if ins is None:
            report.append(f"WARNING correction {c['siruta']} ({c['name']}): this code is not in the INS file any more")
        elif ins == c['ins_name']:
            names[c['siruta']] = c['name']
            applied += 1
        elif ins == c['name']:
            report.append(f"note    correction {c['siruta']}: this INS file already has {c['name']}")
        else:
            report.append(f"WARNING correction {c['siruta']}: INS now has {ins} (expected {c['ins_name']}), "
                          f"correction to {c['name']} NOT applied")
    report.insert(0, f'corrections applied: {applied} of {len(corrections)}')

    level = {r['siruta']: r['level'] for r in rows}
    counties = sorted(((names[r['siruta']], r['county']) for r in rows if r['level'] == 1),
                      key=lambda c: (c[1] == BUCHAREST, romanian_order(c[0])))
    counties = [(code, ABBR[code], name) for name, code in counties]
    locations = []
    for r in sorted((r for r in rows if r['level'] == 3), key=lambda r: r['siruta']):
        if level.get(r['parent']) != 2:
            sys.exit(f"ERROR: location {r['siruta']} has no commune, town or municipality (SIRSUP {r['parent']})")
        locations.append((r['siruta'], r['county'], names[r['siruta']], r['parent'], names[r['parent']]))
    return counties, locations


def validate(counties, locations):
    errors = []
    codes = {c[0] for c in counties}
    if len(counties) != 42 or codes != set(ABBR):
        errors.append(f'expected the 42 known county codes, found {len(counties)}')
    seen = set()
    for siruta, county, name, uat, uat_name in locations:
        if county not in codes:
            errors.append(f'{siruta}: unknown county code {county}')
        key = (county, name, uat_name)
        if key in seen:
            errors.append(f'{siruta}: {name} ({uat_name}) is twice in county {county}')
        seen.add(key)
    for name in {c[2] for c in counties} | {l[2] for l in locations} | {l[4] for l in locations}:
        if not name or len(name) > 50 or set(name) - set(ALPHABET) or re.search(r'  |^[ -]|[ -]$| -|- ', name):
            errors.append(f'unexpected name: "{name}"')
        elif title(name).upper() != name:
            errors.append(f'title case does not match: "{name}"')
    return errors


def sql(counties, locations, case):
    out = ['SET NAMES utf8mb4;', '', '--', f'-- Dumping data for table {COUNTIES}', '--', '',
           f'INSERT INTO {COUNTIES} (`id`, `county_code`, `county_abbr`, `county_name`) VALUES']
    out += [f"({i}, {code}, '{abbr}', '{case(name)}')," for i, (code, abbr, name) in enumerate(counties, 1)]
    out[-1] = out[-1][:-1] + ';'
    out += ['', '--', f'-- Dumping data for table {LOCATIONS}', '--', '',
            f'INSERT INTO {LOCATIONS} (`id`, `siruta`, `county_code`, `location_name`, `uat_siruta`, `uat_name`) VALUES']
    out += [f"({i}, {siruta}, {county}, '{case(name)}', {uat}, '{case(uat_name)}'),"
            for i, (siruta, county, name, uat, uat_name) in enumerate(locations, 1)]
    out[-1] = out[-1][:-1] + ';'
    return '\n'.join(out) + '\n'


# ---------------------------------------------------------------- comparing with the current data

def current_locations(folder):
    path = Path(folder) / UPPER_FILE
    if not path.exists():
        return None
    text = path.read_text(encoding='utf-8')
    return {int(s): (int(s), int(c), n, int(us), un) for _, s, c, n, us, un in ROW.findall(text)}


def compare(old, locations):
    new = {l[0]: l for l in locations}
    added = [new[s] for s in sorted(set(new) - set(old))]
    removed = [old[s] for s in sorted(set(old) - set(new))]
    changed = [(old[s], new[s]) for s in sorted(set(new) & set(old)) if old[s] != new[s]]
    return added, removed, changed


def describe(added, removed, changed):
    lines = [f'compared with the current {UPPER_FILE}: {len(added)} added, {len(removed)} removed, {len(changed)} changed']
    lines += [f'  added    {l[0]} {l[2]} ({l[4]}), county {l[1]}' for l in added]
    lines += [f'  removed  {l[0]} {l[2]} ({l[4]}), county {l[1]}' for l in removed]
    for o, n in changed:
        parts = []
        if o[2] != n[2]:
            parts.append(f'name {o[2]} > {n[2]}')
        if o[1] != n[1]:
            parts.append(f'county {o[1]} > {n[1]}')
        if (o[3], o[4]) != (n[3], n[4]):
            parts.append(f'belongs to {o[4]} ({o[3]}) > {n[4]} ({n[3]})')
        lines.append(f'  changed  {n[0]} {n[2]}: ' + ', '.join(parts))
    return lines


def update_sql(added, removed, changed):
    """SQL for an installation that has the previous data. It keeps the letter case of the installation."""
    both = lambda name: f"IF(@upper, '{name}', '{title(name)}')"
    out = ['SET NAMES utf8mb4;', '',
           '-- 1 when the installation has upper case names, 0 when it has title case names',
           f'SET @upper = (SELECT COUNT(*) = 0 FROM {LOCATIONS} WHERE BINARY `location_name` <> BINARY UPPER(`location_name`));',
           '', 'START TRANSACTION;']
    out += [f'DELETE FROM {LOCATIONS} WHERE `siruta` = {l[0]};' for l in removed]
    out += [f'UPDATE {LOCATIONS} SET `county_code` = {n[1]}, `location_name` = {both(n[2])}, `uat_siruta` = {n[3]}, '
            f'`uat_name` = {both(n[4])} WHERE `siruta` = {n[0]};' for _, n in changed]
    out += [f'INSERT INTO {LOCATIONS} (`siruta`, `county_code`, `location_name`, `uat_siruta`, `uat_name`) VALUES '
            f'({l[0]}, {l[1]}, {both(l[2])}, {l[3]}, {both(l[4])});' for l in added]
    return '\n'.join(out + ['COMMIT;']) + '\n'


# ---------------------------------------------------------------- main

def main():
    sys.stdout.reconfigure(encoding='utf-8')
    parser = argparse.ArgumentParser(description='Build the SQL data files from the INS SIRUTA archive.')
    parser.add_argument('source', nargs='?', help='archive, folder, SIRUTA.xls or siruta.mdb (default: newest archive in source/)')
    parser.add_argument('--from', dest='kind', choices=('xls', 'mdb'),
                        help='file of the archive to read (default: xls, or mdb when the archive has no xls)')
    parser.add_argument('--out', default=str(ROOT), help='folder of the data files (default: the repo)')
    parser.add_argument('--check', action='store_true', help='do not write, exit with 1 if the files would change')
    parser.add_argument('--update-sql', metavar='FILE', help='write the SQL for the differences from the current data')
    args = parser.parse_args()

    rows, where = read_ins(args.source or newest_archive(), args.kind)
    report = []
    counties, locations = build(rows, load_corrections(), report)
    print(f'source: {where}')
    print(f'{len(counties)} counties, {len({l[3] for l in locations})} communes, towns and municipalities, {len(locations)} locations')
    print('\n'.join(report))

    errors = validate(counties, locations)
    if errors:
        print('\n'.join('ERROR ' + e for e in errors[:50]))
        sys.exit(f'{len(errors)} errors, nothing written')

    out = Path(args.out)
    old = current_locations(out)
    if old:
        diff = compare(old, locations)
        print('\n'.join(describe(*diff)))
        if args.update_sql and any(diff):
            Path(args.update_sql).write_text(update_sql(*diff), encoding='utf-8', newline='\n')
            print(f'update statements written to {args.update_sql}')

    files = {UPPER_FILE: sql(counties, locations, str), TITLE_FILE: sql(counties, locations, title)}
    same = all((out / n).exists() and (out / n).read_bytes() == t.encode('utf-8') for n, t in files.items())
    if args.check:
        print('the data files are up to date' if same else 'the data files are DIFFERENT from the build')
        sys.exit(0 if same else 1)
    if same:
        print('the data files are already up to date, nothing written')
        return
    for name, text in files.items():
        (out / name).write_text(text, encoding='utf-8', newline='\n')
        print(f'written {out / name}')


if __name__ == '__main__':
    main()
