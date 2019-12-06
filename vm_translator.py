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
    def __init__(self, vm_name):
        self.vm_name = vm_name

    @staticmethod
    def types():
        return ("push", "pop")

    @staticmethod
    def push(variable, index, addr):
        if addr is not None:
            if index is None:  # constant
                return "@{},D=A,@SP,M=M+1,A=M-1,M=D".format(addr).split(',')
            elif index == '0':  # pointer/static
                return "@{},D=M,@SP,M=M+1,A=M-1,M=D".format(addr).split(',')
            else:  # temp
                return "@{0},D=A,@{1},A=A+D,D=M,@SP,M=M+1,A=M-1,M=D".format(
                    addr, index).split(',')
        else:
            return "@{0},D=M,@{1},A=A+D,D=M,@SP,M=M+1,A=M-1,M=D".format(
                variable, index).split(',')

    @staticmethod
    def pop(variable, index, addr):
        if addr is not None:
            if index == '0':  # pointer/static
                return "@SP,AM=M-1,D=M,@{},M=D".format(addr).split(',')
            else:  # temp
                line_get = "@{0},D=A,@{1},D=A+D,@tmp_addr,M=D,@SP,AM=M-1,D=M,"
                line_put = "@tmp_addr,A=M,M=D"
                return (line_get + line_put).format(addr, index).split(',')
        else:
            line_get = "@{0},D=M,@{1},D=A+D,@tmp_addr,M=D,@SP,AM=M-1,D=M,"
            line_put = "@tmp_addr,A=M,M=D"
            return (line_get + line_put).format(variable, index).split(',')

    def cmd(self, line):
        line = line.split(' ')
        # print(line)
        assert len(line) == 3
        variable, index, addr = self.process_segment(line[1], line[2])
        if line[0] == "push":
            return self.push(variable, index, addr)
        elif line[0] == "pop":
            return self.pop(variable, index, addr)
        else:
            raise ValueError

    def process_segment(self, segment, idx):
        variable, index, address = None, None, None
        if segment == 'constant':
            # addr = idx, *SP = addr, SP++
            address = idx

        elif segment == 'local':
            # *SP = *(*LCL + i), SP++--
            # *(*LCL + i) = *SP
            variable, index = 'LCL', idx
        elif segment == 'argument':
            variable, index = 'ARG', idx
        elif segment == 'this':
            variable, index = 'THIS', idx
        elif segment == 'that':
            variable, index = 'THAT', idx

        elif segment == 'temp':  # RAM[5-12]
            # addr = 5 + i, *SP = *addr, SP++--
            address, index = '5', idx
        elif segment == 'pointer':
            # *SP = *THIS/THAT, SP++
            # SP--, *THIS/ = *SP
            address, index = {'0': 'THIS', '1': 'THAT'}[idx], '0'
        elif segment == 'static':  # RAM[16-255]
            # addr = vm_file.idx, *SP = *addr, SP++--
            address, index = self.vm_name + '.{}'.format(idx), '0'
        else:
            raise TypeError
        # RAM[13-15]: general purpose
        return variable, index, address


def process(lines, vm_name):
    # hacklines = [line.replace(' ', '').replace('\n', '') for line in lines]
    # hacklines = [re.sub('//.*', '', line) for line in hacklines]
    asmlines = []
    memory = Memory(vm_name)
    arithmetic = Arithmetic()
    for line in lines:
        line = line.replace('\n', '')
        if line.startswith("//"):
            asmlines.append(line)
            continue
        line = re.sub('//.*', '', line)
        if not line:
            continue
        if line.startswith(memory.types()):
            asmlines.append("// " + line)
            asmlines.extend(memory.cmd(line))
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
        successes = []
        for path in fpath:
            successes.append(translate(path))
        if all(successes):
            print('\nAll success.')
        return
    print('\nprocessing', fpath)
    with open(fpath, 'r') as f:
        vmlines = f.readlines()
    # vmname = os.path.split(fpath)[1].replace('.vm', '')
    vmname = fpath.replace('/', '.').replace('\\', '.').replace('.vm', '')
    asmlines = process(vmlines, vmname)
    # print('\n'.join(hacklines))
    outpath = fpath.replace('.vm', '.asm')
    with open(outpath, 'w') as f:
        f.writelines([line + '\n' for line in asmlines])
    print(outpath, 'write.')
    testfile = fpath.replace(".vm", ".tst")
    bat = 'tools\\CPUEmulator.bat'
    if os.path.exists(testfile) and os.path.exists(bat):
        result = subprocess.getstatusoutput([bat, testfile])[1]
        print(result)
        return result.startswith("End of script - Comparison ended success")
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
