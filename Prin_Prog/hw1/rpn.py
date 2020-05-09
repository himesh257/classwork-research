firstMat = []
finalMat = []
popMat = []

def rpnProg():

# last in first out (LIFO)
    global firstMat
    global finalMat
    global popMat
    oneSign = ['+','-','*','/']
    x = True
    while x :
        try:
            nums = input()
            firstMat.append(nums)
            popMat.append(nums)
            if nums not in oneSign:
                print(nums)
            if consecutive():
                print(consecutive1())
            elif nums == '~':
                consecutive2(nums)
            else:
                mat(nums)
        except EOFError as error:
            break

def mat(nums):
    if nums == '+':
        ans = float(popMat[0]) + float(popMat[1])
        ans1 = format(ans, '.3f')
        print(ans1)
        pushing(ans1)
        popping(len(popMat))
    elif nums == '-':
        ans = float(popMat[0]) - float(popMat[1])
        ans1 = format(ans, '.3f')
        print(ans1)
        pushing(ans1)
        popping(len(popMat))
    elif nums == '*':
        ans = float(popMat[0]) * float(popMat[1])
        ans1 = format(ans, '.3f')
        print(ans1)
        pushing(ans1)
        popping(len(popMat))
    elif nums == '/':
        if float(firstMat[1]) != 0:
            ans = float(popMat[0]) / float(popMat[1])
            ans1 = format(ans, '.3f')
            print(ans1)
            pushing(ans1)
            popping(len(popMat))
        else:
            print('error: division by 0 ')
            print(float(popMat[0]))

def popping(lens):
    x = 0
    while x<lens:
        popMat.pop(0)
        x+=1

def pushing(ans):
    finalMat.append(ans)

def consecutive():
    sign = ['+','-','*','/']
    one = firstMat[len(firstMat) - 1]
    two = firstMat[len(firstMat) - 2]
    oneOne = (one in sign)
    twoOne = (two in sign)
    if oneOne and twoOne:
        return True

def consecutive1():
    one = firstMat[len(firstMat) - 1]
    two = firstMat[len(firstMat) - 2]
    if one == '+':
        ans1 = float(finalMat[len(finalMat) - 1]) + float(finalMat[len(finalMat) - 2])
        ans2 = format(ans1, '.3f')
        finalMat.append(ans2)
        return ans2
    elif one == '-':
        ans1 = float(finalMat[len(finalMat) - 1]) - float(finalMat[len(finalMat) - 2])
        ans2 = format(ans1, '.3f')
        finalMat.append(ans2)
        return ans2
    elif one == '-':
        ans1 = float(finalMat[len(finalMat) - 1]) * float(finalMat[len(finalMat) - 2])
        ans2 = format(ans1, '.3f')
        finalMat.append(ans2)
        return ans2
    else:
        ans1 = float(finalMat[len(finalMat) - 1]) / float(finalMat[len(finalMat) - 2])
        ans2 = format(ans1, '.3f')
        finalMat.append(ans2)
        return ans2

def consecutive2(nums):
    ans = 0
    ans2 = 0
    ans = int(popMat[1])
    ans2 = -ans
    popMat.pop(1)
    popMat.insert(1, ans2)
    mat(nums)

rpnProg()
