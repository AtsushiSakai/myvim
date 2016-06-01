#! /usr/bin/python 
# -*- coding: utf-8 -*- 
# Atsushi Sakai

typeDict_={}
typeDict_["float"]="%f"
typeDict_["double"]="%lf"
typeDict_["int"]="%d"
typeDict_["long"]="%ld"
typeDict_["short"]="%d"
typeDict_["uint8_t"]="%u"
typeDict_["uint16_t"]="%u"
typeDict_["uint32_t"]="%lu"

def Print(string, color, highlight=False):
    u"""
    Colored print

    colorlist:
        red,green,yellow,blue,magenta,cyan,white,crimson

    """
    end="\033[1;m"
    pstr=""
    if color == "red":
        if highlight:
            pstr+='\033[1;41m'
        else:
            pstr+='\033[1;31m'
    elif color == "green":
        if highlight:
            pstr+='\033[1;42m'
        else:
            pstr+='\033[1;32m'
    elif color == "yellow":
        if highlight:
            pstr+='\033[1;43m'
        else:
            pstr+='\033[1;33m'
    elif color == "blue":
        if highlight:
            pstr+='\033[1;44m'
        else:
            pstr+='\033[1;34m'
    elif color == "magenta":
        if highlight:
            pstr+='\033[1;45m'
        else:
            pstr+='\033[1;35m'
    elif color == "cyan":
        if highlight:
            pstr+='\033[1;46m'
        else:
            pstr+='\033[1;36m'
    elif color == "white":
        if highlight:
            pstr+='\033[1;47m'
        else:
            pstr+='\033[1;37m'
    elif color == "crimson":
        if highlight:
            pstr+='\033[1;48m'
        else:
            pstr+='\033[1;38m'
    else:
        print("Error Unsupported color:"+color)

    print(pstr+string+end)


class StructInfo:
    def __init__(self):
        self.structName=None
        self.members=[] #(type,name)
        

def GetPrintFuncCode(info):
    #Header comments
    code="/**\n"
    code+="* @brief  Print struct "+info.structName+" function\n"
    code+="*/\n"
    #code
    code+="void Print"+info.structName+"("+info.structName+" &data){\n"
    code+='\t printf("====='+info.structName+'=====\\n");\n'
    for vtype,name in info.members:
        try:
            code+='\t printf("'+name+':'+typeDict_[vtype]+'\\n",data.'+name+');\n'
        except KeyError:
            Print("[Error] "+vtype+" is not variable type","red")

    code+="}\n"
    
    return code

def GetStructInfo(code):

    info=StructInfo()

    for line in code.split("\n"):
        if "struct" in line:
            info.structName=line.split(" ")[1].replace("{","")

        elif "};" not in line:
            val=line.split(" ")
            val = filter(lambda s:s != '', val)
            if len(val) >= 2:
                vtype=val[0]
                name=val[1].replace(";","")
                info.members.append((vtype,name))

    return info

def _GetPrintFuncCodeTest():
    info=StructInfo()
    info.structName="TakeFunction"
    info.members.append(("double","x"))
    info.members.append(("float","y"))
    info.members.append(("uint32_t","z"))
    code=GetPrintFuncCode(info)
    print(code)

def _GetStructInfoTest():
    code="""
struct Command{
    uint8_t id;
    float interval;
    ushort ch;
};
    """
    info=GetStructInfo(code)
    print(info.structName)
    print(info.members)
    code=GetPrintFuncCode(info)
    print(code)

if __name__ == '__main__':
    #  _GetPrintFuncCodeTest()
    _GetStructInfoTest()



