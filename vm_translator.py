import os
import sys
import re
import subprocess


class Arithmetic():
    def __init__(self):
        self.eq_count = -1
        self.gt_count = -1
        self.lt_count = -1

    @staticmethod
    def types():
        return ("add", "sub", "neg", "eq", "gt", "lt", "and", "or", "not")

    def cmd(self, line):
        line = line.split(' ')[0]
        if line == "add":
            return "@SP,AM=M-1,D=M,A=A-1,M=D+M".split(',')
        elif line == "sub":
            return "@SP,AM=M-1,D=M,A=A-1,M=M-D".split(',')
        elif line == "neg":
            return "@SP,A=M-1,M=-M".split(',')
        elif line == "eq":
            self.eq_count += 1
            linecal = "@bool,M=-1,@SP,AM=M-1,D=M,A=A-1,D=M-D,"
            lineeq = "@EQ_TRUE_{0},D;JEQ,@bool,M=0,(EQ_TRUE_{0}),"
            linebool = "@bool,D=M,@SP,A=M-1,M=D"
            return (linecal + lineeq + linebool).format(
                self.eq_count).split(',')
        elif line == "gt":
            self.gt_count += 1
            linecal = "@bool,M=-1,@SP,AM=M-1,D=M,A=A-1,D=M-D,"
            linegt = "@GT_TRUE_{0},D;JGT,@bool,M=0,(GT_TRUE_{0}),"
            linebool = "@bool,D=M,@SP,A=M-1,M=D"
            return (linecal + linegt + linebool).format(
                self.gt_count).split(',')
        elif line == "lt":
            self.lt_count += 1
            linecal = "@bool,M=-1,@SP,AM=M-1,D=M,A=A-1,D=M-D,"
            linelt = "@LT_TRUE_{0},D;JLT,@bool,M=0,(LT_TRUE_{0}),"
            linebool = "@bool,D=M,@SP,A=M-1,M=D"
            return (linecal + linelt + linebool).format(
                self.lt_count).split(',')
        elif line == "and":
            return "@SP,AM=M-1,D=M,A=A-1,M=D&M".split(',')
        elif line == "or":
            return "@SP,AM=M-1,D=M,A=A-1,M=D|M".split(',')
        elif line == "not":
            return "@SP,A=M-1,M=!M".split(',')
        else:
            raise TypeError


class Memory():
    @staticmethod
    def types():
        return ("push", "pop")

    @staticmethod
    def push(segment, index):
        if segment is None:
            return "@{},D=A,@SP,M=M+1,A=M-1,M=D".format(index).split(',')

    @staticmethod
    def pop(segment, index):
        if segment is None:
            return "@{},D=A,@SP,M=M-1,A=M,M=D".format(index).split(',')

    @staticmethod
    def cmd(line):
        line = line.split(' ')
        # print(line)
        assert len(line) == 3
        segment = Memory.process_segment(line[1])
        if line[0] == "push":
            return Memory.push(segment, line[2])
        elif line[0] == "pop":
            return Memory.pop(segment, line[2])
        else:
            raise ValueError

    @staticmethod
    def process_segment(segment):
        if segment == 'constant':
            return None


def process(lines):
    # hacklines = [line.replace(' ', '').replace('\n', '') for line in lines]
    # hacklines = [re.sub('//.*', '', line) for line in hacklines]
    asmlines = []
    arithmetic = Arithmetic()
    for line in lines:
        line = line.replace('\n', '')
        if line.startswith("//"):
            asmlines.append(line)
            continue
        line = re.sub('//.*', '', line)
        if not line:
            continue
        if line.startswith(Memory.types()):
            asmlines.append("// " + line)
            asmlines.extend(Memory.cmd(line))
        elif line.startswith(arithmetic.types()):
            asmlines.append("// " + line)
            asmlines.extend(arithmetic.cmd(line))

    # line_true = "@END,0;JMP,(TRUE),@bool,M=-1,A=D,0;JMP,"
    # line_false = "(FALSE),@bool,M=0,A=D,0;JMP,"
    end = "(END),@END,0;JMP"
    asmlines.extend((end).split(','))
    asmlines = [line if line.startswith(("(", "//")) else '   ' + line
                for line in asmlines]
    # print('\n'.join(asmlines))
    return asmlines


def translate(fpath):
    if isinstance(fpath, list):
        for path in fpath:
            translate(path)
        return
    print('\nprocessing', fpath)
    with open(fpath, 'r') as f:
        vmlines = f.readlines()
    asmlines = process(vmlines)
    # print('\n'.join(hacklines))
    outpath = fpath.replace('.vm', '.asm')
    with open(outpath, 'w') as f:
        f.writelines([line + '\n' for line in asmlines])
    print(outpath, 'write.')
    testfile = fpath.replace(".vm", ".tst")
    bat = 'tools\\CPUEmulator.bat'
    if os.path.exists(testfile) and os.path.exists(bat):
        print(subprocess.getstatusoutput([bat, testfile])[1])
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
        translate(dir_)
    else:
        paths = []
        for root, dirs, files in os.walk(dir_):
            for f in files:
                if f.endswith('.vm'):
                    paths.append(os.path.join(root, f))
        # print(paths)
        translate(paths)


# %%
