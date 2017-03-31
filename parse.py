import re


def loadFile(filename):
    with open(filename, "r") as signalFile:
        lines = signalFile.readlines()
    return lines

class Parser():

    def __init__(self, filename):
        self.filename=filename
        self.file = loadFile(filename)
        self.getModules()

    def getModules(self):
        lines=[[]]
        inside=0
        for line in self.file:
            if line[0:6] == "module":
                inside = 1
            if inside:
                lines[-1].append(line[:-1])
            if line[0:9] == "endmodule":
                lines.append([])
                inside = 0
        self.modules = [];
        for elem in lines[:-1]:
            self.modules.append(Module(elem))
#        for i in range(len(self.modules)):
#            str=""
#            for j in range(len(self.modules[i])):
#                str=str+self.modules[i][j]
#            self.modules[i]=str

class Module:
    def __init__(self,lines):
        self.lines=lines
        self.moduleName=""
        self.parameterNames=""
        self.inputs=[]
        self.outputs=[]
        self.wires=[]
        self.components=[]
        self._validnames=[]
        self.getBasicData()
        self.getIOdata()
        self.getComponents()

    def __str__(self):
        strn="Module name: %s\n"%(self.moduleName)
        strn=strn+"Inputs:\n"
        for elem in self.inputs:
            strn=strn+str(elem)+'\n'
        strn=strn+"Outputs:\n"
        for elem in self.outputs:
            strn=strn+str(elem)+'\n'
        return strn

    def getBasicData(self):
        names=[]
        expr = r"[\(,]?\s*(\w+)\s*[\),]?"
        self._startLine=0
        for line in self.lines:
            names = names + re.findall(expr,line,re.I)
            self._startLine=self._startLine+1
            if ';' in line:
                break

        self.moduleName=names[1]
        self.parameterNames=names[2:]

    def getIOdata(self):
        incont=0
        outcont=0
        wicont=0
        currwidth=1
        for line in self.lines[self._startLine:]:

            if line[2:7] == "input" or incont:
                if incont != 1:
                    currwidth=1
                    expr = r"\[(\d*):(\d*)\]"
                    match=re.findall(expr,line)
                    if len(match) > 0:
                        currwidth=abs(int(match[0][0])-int(match[0][1])+1)
                expr=r"[,]?\s*([a-zA-Z]+\w+)\s*[,]?"
                match=re.findall(expr, line, re.I)
                if incont == 0:
                    for elem in match[1:]:
                        self.inputs.append((elem,currwidth))
                else:
                    for elem in match:
                        self.inputs.append((elem,currwidth))
                incont = ';' not in line

            if line[2:8] == "output" or outcont:
                if outcont != 1:
                    currwidth=1
                    expr = r"\[(\d*):(\d*)\]"
                    match=re.findall(expr,line)
                    if len(match) > 0:
                        currwidth=abs(int(match[0][0])-int(match[0][1])+1)
                expr=r"[,]?\s*([a-zA-Z]+\w+)\s*[,]?"
                match=re.findall(expr, line, re.I)
                if outcont == 0:
                    for elem in match[1:]:
                        self.outputs.append((elem,currwidth))
                else:
                    for elem in match:
                        self.outputs.append((elem,currwidth))
                outcont = ';' not in line

            if line[2:6] == "wire" or wicont:
                if wicont != 1:
                    currwidth=1
                    expr = r"\[(\d*):(\d*)\]"
                    match=re.findall(expr,line)
                    if len(match) > 0:
                        currwidth=abs(int(match[0][0])-int(match[0][1])+1)
                expr=r"[,]?\s*([a-zA-Z]+\w+)\s*[,]?"
                match=re.findall(expr, line, re.I)
                if wicont == 0:
                    for elem in match[1:]:
                        self.wires.append((elem,currwidth))
                else:
                    for elem in match:
                        self.wires.append((elem,currwidth))
                wicont = ';' not in line

            self._startLine=self._startLine+1
            if len(line) == 0:
                break
        while True:
            if len(self.lines[self._startLine]) == 0:
                self._startLine=self._startLine+1
            else:
                break;

        return

    def getComponents(self):

        multline=0
        inargs=[]
        innames=[]
        currlines=""
        for line in self.lines[self._startLine:-1]:
            if not multline:
                currlines=line
            else:
                currlines=currlines+line[8:]

            multline = ';' not in line
            if not multline:
                expr = r"[\(,]?\s*([\\]?[a-zA-Z]+\w*(\[(\d+)\])?)\s*[\),]?"
                match = re.findall(expr,currlines,re.I)
                gate=match[0][0]
                if len(match[1][1]) == 0:
                    name=(match[1][0],1)
                else:
                    name=(match[1][0].split('[')[0],int(match[1][2]))
                self.components.append(Component(gate,name))

                expr = r"\w\((.*?)\)"
                inargs = re.findall(expr,currlines,re.I)
                expr = r"\.(.*?)\("
                innames = re.findall(expr,currlines,re.I)
                self.components[-1].addPins(innames,inargs)
                currlines=""

        return


class Component():

    def __init__(self,gate,name):
        self.name=name
        self.gate=gate
        self.pins=[]
        return

    def addPins(self,pinName,inputs):
        for name,inp in zip(pinName,inputs):
            self.pins.append((name, self.parsePinInput(inp)))
        return

    def parsePinInput(self,inputstr):
        if '{' in inputstr:
            return self.splitArr(inputstr)
        if "'" in inputstr:
            return self.getConstVal(inputstr)
        if '[' in inputstr:
            return self.getNameIndex(inputstr)
        return inputstr

    def getNameIndex(self,instr):
        temp = instr.split('[')
        return (temp[0], temp[1][:-1])

    def getConstVal(self,instr):
        return instr

    def splitArr(self,instr):
        temp=instr.split(',')
        temp[0]=temp[0][1:]
        temp[-1]=temp[-1][:-1]
        for i in range(len(temp)):
            temp[i]=self.parsePinInput(temp[i])
        return temp

    def isValidName(self,name):
        if len(self._validnames) == 0:
            self._validnames = ["INVX2", "OAI22X1", "INVX1","NAND2X1","XOR2X1","XNOR2X1"]
        return name in self._validnames

    def __str__(self):
        strn="Gate/Module: %s   |  Name: %s\n"%(self.gate,self.name)
        for elem in self.pins:
            strn=strn+str(elem)+'\n'
        return strn

if __name__ == "__main__":
    p = Parser("rcv_block.v")
    for elem in p.modules:
        print(elem)
        for comp in elem.components:
            #print(comp)
            pass
