
#Adidev Mohapatra 230007601
import re

# Adding Predefined Symbols to Table###########################################

symbolTable = {}
symbolTable['SP'] = 0
symbolTable['LCL'] = 1
symbolTable['ARG'] = 2
symbolTable['THIS'] = 3
symbolTable['THAT'] = 4

for r in range(16):
    symbolTable['R' + str(r)] = r
    symbolTable['SCREEN'] = 16384
    symbolTable['KBD'] = 24576


# Adding Labels to Table#######################################################


def contains(dictionary, value):
    if (value in dictionary):
        return True
    else:
        return False


def removeCommentsAndWhitespace(value):
    value = value.replace(" ", "")
    return value


def isLabel(value):
    if value.isspace() or len(value) < 3:
        return False
    if (value[0] == '(' and value[-1] == ')'):
        return True
    else:
        return False


def removeParenthesis(value):
    if (isLabel(value) == True):
        value = value[1:-1]
        return value


file = open("gcd.asm", "r")
pc = 1  # refer to location in file
linenumber = 0
for line in file:
    line = line.replace(" ", "")
    if (line[0] == '/' or len(line.strip()) == 0):
        continue
    line = line.strip()
    print(line)
    clean = line.split('/')
    clean = clean[0]
    bean = clean.strip()
    linenumber +=1
    if (bean == ''):
        linenumber -= 1
    if(isLabel(bean) == True):
        linenumber-=1
        
    if (isLabel(bean)):
        label = removeParenthesis(bean)
        
        if (not contains(symbolTable, label)):
            symbolTable[label] = linenumber
            #print("This is a Label: ", label)
    if (not isLabel(bean)):
        pc = pc + 1

    # Adding Variables to Table####################################################

nextAddress = 16  # variable assigned starting at addr 16


def isValidAInstruction(value):
    if (value[0] == '@'):
        return True
    else:
        return False


def isNotNumber(value):
    if (not value.isnumeric()):
        return True
    else:
        return False


file = open("gcd.asm", "r")

for line in file:
    if (line[0] == '/' or len(line) == 0):
        continue
    clean = removeCommentsAndWhitespace(line)
    clean = clean.split('/')
    clean = clean[0]
    # clean = clean.strip()
    if (isValidAInstruction(clean)):
        clean = clean.strip()
        AInstructionVal = clean.strip('@')

        if (not AInstructionVal.isdigit() and not (contains(symbolTable, AInstructionVal))):
            symbolTable[AInstructionVal] = nextAddress
            nextAddress = nextAddress + 1



# Comp Table###################################################################

compTable = {}
compTable['0'] = '0101010'
compTable['1'] = '0111111'
compTable['-1'] = '0111010'
compTable['D'] = '0001100'
compTable['A'] = '0110000'
compTable['!D'] = '0001101'
compTable['!A'] = '0110001'
compTable['-D'] = '0001111'
compTable['-A'] = '0110011'
compTable['D+1'] = '0011111'
compTable['A+1'] = '0110111'
compTable['D-1'] = '0001110'
compTable['A-1'] = '0110010'
compTable['D+A'] = '0000010'
compTable['A+D'] = '0000010'
compTable['D-A'] = '0010011'
compTable['A-D'] = '0000111'
compTable['D&A'] = '0000000'
compTable['A&D'] = '0000000'
compTable['D|A'] = '0010101'
compTable['A|D'] = '0010101'
compTable['M'] = '1110000'
compTable['!M'] = '1110001'
compTable['-M'] = '1110011'
compTable['M+1'] = '1110111'
compTable['M-1'] = '1110010'
compTable['D+M'] = '1000010'
compTable['M+D'] = '1000010'
compTable['D-M'] = '1010011'
compTable['M-D'] = '1000111'
compTable['D&M'] = '1000000'
compTable['M&D'] = '1000000'
compTable['D|M'] = '1010101'
compTable['M|D'] = '1010101'

# Dest Table###################################################################

destTable = {}
destTable['M'] = '001'
destTable['D'] = '010'
destTable['MD'] = '011'
destTable['A'] = '100'
destTable['AM'] = '101'
destTable['AD'] = '110'

# Jump Table###################################################################

jumpTable = {}
jumpTable['JGT'] = '001'
jumpTable['JEQ'] = '010'
jumpTable['JGE'] = '011'
jumpTable['JLT'] = '100'
jumpTable['JNE'] = '101'
jumpTable['JLE'] = '110'
jumpTable['JMP'] = '111'

# Main Implementation##########################################################


asmFileName = 'gcd.asm'

file = open("gcd.asm", "r")

if (not file):
    print('failed to open file')
    exit()

fileNameWithoutExtension = asmFileName.strip('.asm')


# Main Implementation p2#######################################################


def isAInstruction(line):
    if (line[0] != '@'):
        return False

    dropAt = line[1: len(line)]
    # print(dropAt)

    if (dropAt.isdigit()):
        return True
    if (contains(symbolTable, dropAt)):
        return True

    if (dropAt[0].isnumeric()):
        return False

    return False


def aInstruction(line):
    dropAt = line[1: len(line)]

    if (dropAt.isdigit()):
        dropAt = int(dropAt)
        bin = "{0:015b}".format(dropAt)
        return ('0' + bin)

    if (contains(symbolTable, dropAt)):
        bin = symbolTable[dropAt]
        bin = int(bin)
        bin = "{0:015b}".format(bin)
        return ('0' + bin)

    if (dropAt.isalpha()):
        bin = symbolTable[dropAt]
        bin = int(bin)
        bin = "{0:015b}".format(bin)
        return ('0' + bin)

    return 'error'


def countChars(line, value):
    return line.count(value)


def isCInstruction(line):
    if not ((countChars(line, '=') == 1 or countChars(line, ';') == 1)):
        return False

    tokens = re.split('=|;', line)
    if (len(tokens) != 2 and len(tokens) != 3):
        return False

    if (len(tokens) == 2):
        if (countChars(line, '=') == 1):
            if (not contains(destTable, tokens[0])):
                return False
            if (not contains(compTable, tokens[1])):
                return False

        else:
            if (not contains(compTable, tokens[0])):
                return False
            if (not contains(jumpTable, tokens[1])):
                return False

    else:
        if (not contains(destTable, tokens[0])):
            return False
        if (not contains(compTable, tokens[1])):
            return False
        if (not contains(jumpTable, tokens[2])):
            return False

    return True


def cInstruction(line):
    tokens = re.split('=|;', line)

    prefix = '111'

    if (len(tokens) == 2):
        if (countChars(line, '=') == 1):
            dest = destTable[tokens[0]]
            comp = compTable[tokens[1]]
            jump = '000'

            if (len(dest) == 0 or len(comp) == 0):
                return 'error'

        else:
            dest = '000'
            comp = compTable[tokens[0]]
            jump = jumpTable[tokens[1]]

            if (len(dest) == 0 or len(comp) == 0):
                return 'error'
    else:
        dest = destTable[tokens[0]]
        comp = compTable[tokens[1]]
        jump = jumpTable[tokens[2]]

        if (len(dest) == 0 or len(comp) == 0 or len(jump) == 0):
            return 'error'

    return prefix + comp + dest + jump


#########################Main Implementation#################################


binaryFileOut = open(fileNameWithoutExtension + '.hack', "w")

file = open("gcd.asm", "r")

for line in file:
    if (line[0] == '/' or len(line) == 0):
        continue
    clean = removeCommentsAndWhitespace(line)
    clean = clean.split('/')
    clean = clean[0]
    clean = clean.strip()

    if (len(clean) == 0):
        continue

    if (isAInstruction(clean)):
        bin = aInstruction(clean)
       
        binaryFileOut.write(bin + '\n')

        continue

    if (isCInstruction(clean)):
        bin = cInstruction(clean)
        
        binaryFileOut.write(bin + '\n')
        continue

binaryFileOut.close()
file.close()


