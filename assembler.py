import os
import sys
import re

#
def parseC(line):
    '''parse C-instruction line'''
    # C: AMD = A+D ; JMP
    ieq = line.find('=')
    strdest = line[:ieq] if ieq != -1 else ''
    line = line[ieq+1:] if ieq != -1 else line
    icolon = line.find(';')
    strcomp = line[:icolon] if icolon != -1 else line
    strjump = line[icolon+1:] if icolon != -1 else ''
    # comp
    comp = {'0': '0101010', '1': '0111111', '-1': '0111010',
            'D': '0001100', 'A': '0110000', 'M': '1110000',
            '!D': '0001101', '!A': '0110001', '!M': '1110001',
            '-D': '0001111', '-A': '0110011', '-M': '1110011',
            'D+1': '0011111', '1+D': '0011111', 'A+1': '0110111',
            '1+A': '0110111', 'M+1': '1110111', '1+M': '1110111',
            'D-1': '0001110', 'A-1': '0110010', 'M-1': '1110010',
            'D+A': '0000010', 'A+D': '0000010', 'D+M': '1000010',
            'M+D': '1000010', 'D-A': '0010011', 'D-M': '1010011',
            'A-D': '0000111', 'M-D': '1000111', 'D&A': '0000000',
            'A&D': '0000000', 'D&M': '1000000', 'M&D': '1000000',
            'D|A': '0010101', 'A|D': '0010101', 'D|M': '1010101',
            'M|D': '1010101'}[strcomp] if strcomp else '0'* 7
    # dest
    dest = list('000')
    if 'A' in strdest:
        dest[0] = '1'
    if 'D' in strdest:
        dest[1] = '1'
    if 'M' in strdest:
        dest[2] = '1'
    dest = ''.join(dest)
    # jump
    jump = {'null': '000', 'JGT': '001', 'JEQ': '010',
            'JGE': '011', 'JLT': '100', 'JNE': '101',
            'JLE': '110', 'JMP': '111'
            }[strjump] if strjump else '000'
    return '111' + comp + dest + jump
# parseC("D=D-A")
# parseC("0;JMP")


def process(lines):
    # hacklines = [line.replace(' ', '').replace('\n', '') for line in lines]
    # hacklines = [re.sub('//.*', '', line) for line in hacklines]
    variables = {'SP': 0, 'LCL': 1, 'ARG': 2, 'THIS': 3,
                 'THAT': 4, 'SCREEN': 16384, 'KBD': 24576}
    for i in range(16):
        variables['R' + str(i)] = i
    i = 0
    nobracketlines = []
    for line in lines:  # clean, and save line numbers
        line = line.replace(' ', '').replace('\n', '')
        line = re.sub('//.*', '', line)
        if not line:
            continue
        if line[0] == '(' and line[-1] == ')':  # re.match('\(.+\)', line):
            variables[line[1:-1]] = i  #  variables[line.replace('(', '').replace(')', '')] = i
            continue
        nobracketlines.append(line)
        i += 1
    hacklines, i = [], 16
    for line in nobracketlines:
        # A: @some
        # C: AMD = A+D ; JMP
        if line.startswith('@'):
            if re.match('[a-zA-Z\.]+', line[1:]):
                if line[1:] not in variables:
                    variables[line[1:]] = i
                    i += 1
                line = '0' + '{:0>15b}'.format(variables[line[1:]])
            else:
                line = '0' + '{:0>15b}'.format(int(line[1:]))
        else:
            line = parseC(line)
        hacklines.append(line)
    # print(hacklines)
    return hacklines


def assemble(fpath):
    if isinstance(fpath, list):
        for path in fpath:
            assemble(path)
        return
    print('processing', fpath)
    with open(fpath, 'r') as f:
        asmlines = f.readlines()
    hacklines = process(asmlines)
    # print('\n'.join(hacklines))
    outpath = fpath.replace('.asm', '.hack')
    with open(outpath, 'w') as f:
        f.writelines([line + '\n' for line in hacklines])
    print(outpath, 'write.')
    return


if __name__ == "__main__":
    dir_ = None
    if len(sys.argv) > 1:
        dir_ = sys.argv[1]

    if dir_ is None or (not os.path.exists(dir_)) or (
            (not os.path.isdir(dir_) or (not os.listdir(dir_)))
            and (not os.path.isfile(dir_))):
        dir_ = input('please input directory or file:')
        if not dir_:
            sys.exit(0)

    if os.path.isfile(dir_):
        assemble(dir_)
    else:
        paths = []
        for root, dirs, files in os.walk(dir_):
            for f in files:
                if f.endswith('.asm'):
                    paths.append(os.path.join(root, f))
        # print(paths)
        assemble(paths)


# %%
