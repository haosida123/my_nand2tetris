import os
import subprocess
import sys

BAT = 'tools\\HardwareSimulator.bat'

def test(files):
    succe = []
    print('')
    all_success = True
    for file in files:
        if file.endswith('hdl'):
            file = file[:-3] + 'tst'
        res = subprocess.getstatusoutput([BAT, file])
        if not res[1].startswith("End of script - Comparison ended success"):
            print('Failure: ', os.path.split(file)[-1][:-3], res[1][:200])
            all_success = False
        else: succe.append(os.path.split(file)[-1][:-4])
    if succe: print('\nSuccess:', ', '.join(succe))
    if all_success: print('Congrats. ALl successful.')

if __name__ == "__main__":
    dir_ = None
    if len(sys.argv) > 1:
        dir_ = sys.argv[1]
    
    if dir_ is None or (not os.path.exists(dir_)) or ( 
            (not os.path.isdir(dir_) or (not os.listdir(dir_))) \
            and (not os.path.isfile(dir_))):
        dir_ = input('please input directory or file:')
        if not dir_:
            os.startfile(BAT)
            sys.exit(0)

    if os.path.isfile(dir_):
        test([dir_])
    else:
        files = []
        for file in os.listdir(dir_):
            if file.endswith('.tst'):
                files.append(os.path.join(dir_, file))
        test(files)
