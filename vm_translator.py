import os
import sys
import re
import subprocess
from collections import namedtuple
from collections import defaultdict


class Coder():
    def __init__(self, filename):
        self.filename = filename
        self.eq_count = -1
        self.gt_count = -1
        self.lt_count = -1
        self.jump_count = -1
        self.funcstack = []  # currently not a stack
        self.func_count = defaultdict(lambda: -1)
        self.translator = {
            ("add", "sub", "neg", "eq", "gt", "lt", "and", "or", "not"):
                self.arithmetic_cmd,
            ("push", "pop"): self.memory_cmd,
            ("goto", "if-goto", "label"): self.goto_cmd,
            ("call", "function", "return"): self.func_cmd
        }

    def translate(self, line):
        for k, cmd in self.translator.items():
            for start in k:
                if line.startswith(start):
                    return cmd(line)
        else:
            raise TypeError(line + '\nvm command type not found')

    def arithmetic_cmd(self, line):
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
            lineeq = "@{1}$EQ_TRUE_{0},D;JEQ,@bool,M=0,({1}$EQ_TRUE_{0}),"
            linebool = "@bool,D=M,@SP,A=M-1,M=D"
            return (linecal + lineeq + linebool).format(
                self.eq_count, self.filename).split(',')
        elif line == "gt":
            self.gt_count += 1
            linecal = "@bool,M=-1,@SP,AM=M-1,D=M,A=A-1,D=M-D,"
            linegt = "@{1}$GT_TRUE_{0},D;JGT,@bool,M=0,({1}$GT_TRUE_{0}),"
            linebool = "@bool,D=M,@SP,A=M-1,M=D"
            return (linecal + linegt + linebool).format(
                self.gt_count, self.filename).split(',')
        elif line == "lt":
            self.lt_count += 1
            linecal = "@bool,M=-1,@SP,AM=M-1,D=M,A=A-1,D=M-D,"
            linelt = "@{1}$LT_TRUE_{0},D;JLT,@bool,M=0,({1}$LT_TRUE_{0}),"
            linebool = "@bool,D=M,@SP,A=M-1,M=D"
            return (linecal + linelt + linebool).format(
                self.lt_count, self.filename).split(',')
        elif line == "and":
            return "@SP,AM=M-1,D=M,A=A-1,M=D&M".split(',')
        elif line == "or":
            return "@SP,AM=M-1,D=M,A=A-1,M=D|M".split(',')
        elif line == "not":
            return "@SP,A=M-1,M=!M".split(',')
        else:
            raise TypeError

    def _push(self, variable, index, addr):
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

    def _pop(self, variable, index, addr):
        if addr is not None:
            if index == '0':  # pointer/static
                return "@SP,AM=M-1,D=M,@{},M=D".format(addr).split(',')
            else:  # temp
                line_get = "@{0},D=A,@{1},D=A+D,@{2}$tmp_addr,M=D,"
                line_put = "@SP,AM=M-1,D=M,@{2}$tmp_addr,A=M,M=D"
                return (line_get + line_put).format(
                    addr, index, self.filename).split(',')
        else:
            line_get = "@{0},D=M,@{1},D=A+D,@{2}$tmp_addr,M=D,@SP,AM=M-1,D=M,"
            line_put = "@{2}$tmp_addr,A=M,M=D"
            return (line_get + line_put).format(
                variable, index, self.filename).split(',')

    def memory_cmd(self, line):
        line = line.split(' ')
        # print(line)
        if not len(line) == 3:
            print(line)
            raise TypeError('line part not equal to 3')
        variable, index, addr = self._memory_segment(line[1], line[2])
        if line[0] == "push":
            return self._push(variable, index, addr)
        elif line[0] == "pop":
            return self._pop(variable, index, addr)
        else:
            raise ValueError

    def _memory_segment(self, segment, idx):
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
            address, index = self.filename + '.{}'.format(idx), '0'
        else:
            raise TypeError
        # RAM[13-15]: general purpose
        return variable, index, address

    def goto_cmd(self, line):
        line = line.split(' ')
        assert len(line) == 2
        line[1] = self.filename + '.' + line[1]  # filename.LABEL
        if line[0] == 'goto':
            return "@{0},0;JMP".format(line[1]).split(',')
        elif line[0] == 'if-goto':
            self.jump_count += 1
            label_name = self.filename
            if len(self.funcstack) > 0:
                label_name = self.funcstack[-1]
            return "@SP,AM=M-1,D=M,@{1}$JMP_{2},D;JEQ,@{0},0;JMP,({1}$JMP_{2})".format(
                line[1], label_name, self.jump_count).split(',')
        elif line[0] == 'label':
            return ["({0})".format(line[1])]
        else:
            raise TypeError()

    def func_cmd(self, line):
        line = line.split(' ')
        if not len(line) == 3:
            assert line[0] == 'return'
        if line[0] == 'call':
            self.func_count[line[1]] += 1
            func_label = "{funcname}$ret.{i}".format(
                **{'funcname': line[1], 'i': self.func_count[line[1]]})
            push_asm = "@{},D=A,@SP,M=M+1,A=M-1,M=D,".format(
                func_label).split(",")
            pushsome = "LCL>>ARG>>THIS>>THAT".split('>>')
            for addr in pushsome:
                push_asm.extend(self._push(
                    variable=None, index='0', addr=addr))
            # line[2]: nArgs
            linearg = "@5,D=A,@{},D=D+A,@SP,D=M-D,@ARG,M=D,".format(line[2])
            linelcl = "@SP,D=M,@LCL,M=D,"
            linejmp = "@{funcname},0;JMP,({func_label})".format(
                **{'funcname': line[1], 'func_label': func_label})
            return push_asm + (linearg + linelcl + linejmp).split(',')
        elif line[0] == 'function':
            # self.funcstack.append(line[1])
            self.funcstack = [line[1]]
            ret = "({}),".format(line[1])  # (funcName)
            for _ in range(int(line[2])):  # push n local vars = 0
                ret += "@SP,M=M+1,A=M-1,M=0,"
            return ret[:-1].split(',')
        elif line[0] == 'return':
            # if len(self.funcstack) <= 0:
            #     return ["something wrong here"]
            # self.funcstack.pop()
            ret = "@LCL,D=M,@{0}$tmp_addr,M=D,"  # save LCL
            ret += "@5,A=D-A,D=M,@{0}$tmp_ret,M=D,"   # save return
            ret += "@SP,AM=M-1,D=M,@ARG,A=M,M=D,D=A+1,@SP,M=D,"  # save SP
            ret += "@{0}$tmp_addr,AM=M-1,D=M,@THAT,M=D,"
            ret += "@{0}$tmp_addr,AM=M-1,D=M,@THIS,M=D,"
            ret += "@{0}$tmp_addr,AM=M-1,D=M,@ARG,M=D,"
            ret += "@{0}$tmp_addr,AM=M-1,D=M,@LCL,M=D,"
            ret += "@{0}$tmp_ret,A=M,0;JMP"  # goto return_label
            return ret.format(self.filename).split(',')


class Parser():
    def __init__(self, filedir):
        Lines = namedtuple('NamedLines', ['name', 'vmlines'])
        if isinstance(filedir, str) and os.path.isfile(filedir):
            self.name = os.path.split(filedir)[1].replace('.vm', '')
            with open(filedir, 'r') as f:
                self.filelines = [Lines(self.name, f.readlines())]
            self.init = False
        elif isinstance(filedir, Vmdir):
            self.name = filedir.name
            self.filelines = []
            for file in filedir.files:
                with open(os.path.join(filedir.root, file), 'r') as f:
                    lines = f.readlines()
                self.filelines.append(
                    Lines(self.name + '.' + file.replace('.vm', ''), lines))
            self.init = True
        else:
            raise TypeError('Type not understood')

    def parse(self):
        # hacklines = [line.replace(' ', '').replace('\n', '') for line in lines]
        # hacklines = [re.sub('//.*', '', line) for line in hacklines]
        asmlines = []
        if self.init:
            # asmlines.extend("@Sys.init,0;JMP".split(','))
            # asmlines.extend("@256,D=A,@SP,M=D,@Sys.init,0;JMP".split(','))
            asmlines.extend("@261,D=A,@SP,M=D,@Sys.init,0;JMP".split(','))
        coder = Coder(self.name)
        for fileline in self.filelines:
            asmlines.append("({}.vm)".format(fileline.name))
            # ops = [Memory, Arithmetic, Goto, Func]
            # ops = [op(fileline.name) for op in ops]
            coder.filename = fileline.name
            for line in fileline.vmlines:
                line = line.replace('\n', '')
                if line.startswith("//"):
                    asmlines.append(line)
                    continue
                line = re.sub('^\s+', '', line)
                line = re.sub('\s+$', '', line)
                if not line:
                    continue
                asmlines.append("// " + line)
                line = re.sub('\s+$', '', re.sub('//.*', '', line))
                asmlines.extend(coder.translate(line))
                # for op in ops:
                #     if line.startswith(op.types()):
                #         asmlines.extend(op.cmd(line))
                #         break
                # else:
                #     raise TypeError('operation types not understood')

        # end = "(END),@END,0;JMP"
        # asmlines.extend((end).split(','))
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
            print('\nAll successfully passed.')
        return
    print('\nprocessing', fpath)
    parser = Parser(fpath)
    asmlines = parser.parse()
    if isinstance(fpath, Vmdir):
        fpath = os.path.join(fpath.root, fpath.name + '.vm')
    outpath = fpath.replace('.vm', '.asm')
    with open(outpath, 'w') as f:
        f.writelines([line + '\n' for line in asmlines])
    print(outpath, 'write.')
    testfile = fpath.replace(".vm", ".tst")
    # print(testfile)
    bat = 'tools\\CPUEmulator.bat'
    if os.path.exists(testfile) and os.path.exists(bat):
        # print('testing', testfile)
        result = subprocess.getstatusoutput([bat, testfile])[1]
        if result.startswith("End of script - Comparison ended success"):
            return True
        print("file", testfile.replace(".tst", ".out"),
              testfile.replace(".tst", ".cmp"))
        print(result)
        return False
    return


class Vmdir():
    def __init__(self, root, files):
        self.root = root
        self.files = []
        self.name = os.path.split(self.root)[1]
        assert len(self.name) > 0, 'name should not be empty'
        for f in files:
            if f.endswith('.vm'):
                self.files.append(f)

    def __str__(self):
        return 'Vmdir ' + '\t'.join([
            os.path.join(self.root, f) for f in self.files])


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

    vmfiles = []
    vmdirs = []
    if os.path.isfile(dir_):
        vmfiles.append(dir_)
    else:
        for root, dirs, files in os.walk(dir_):
            if (sum([f.endswith('.vm') for f in files]) > 0
                    and os.path.split(root)[1]
                    not in [f.replace('.vm', '') for f in files]
                ) \
                    or sum([f.endswith('.vm') for f in files]) > 1:
                vmdir = Vmdir(root, files)
                vmdirs.append(vmdir)
            else:
                for f in files:
                    if f.endswith('.vm'):
                        vmfiles.append(os.path.join(root, f))
    # print('\n'.join(vmfiles))
    # print('\n'.join([str(v) for v in vmdirs]))
    translate(vmfiles + vmdirs)


# %%
