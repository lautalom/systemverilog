
from parse import *
data = "./main.list"
i=0
with open(data) as f:
    lines = f.readlines()
    result = []
    for l in lines[6:]:
        # check if line is an instruction
        if '\t' in l:
            result.append('32\'h'+l.split()[1])
            i+=1
    print(*result, sep=',\n')
print("total instr: ", i)



            