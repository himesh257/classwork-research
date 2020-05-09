firstMat = []
finalMat = []
popMat = []
def rpnProg():

    # last in first out (LIFO)
    global firstMat
    global finalMat
    global popMat
    x = True
    while x :
        nums = input()
        firstMat.append(nums)
        popMat.append(nums)
        if consecutive():
            print(consecutive1())
        else:
            if nums == '+':
                ans = float(popMat[0]) + float(popMat[1])
                ans1 = format(ans, '.3f')
                print(ans1)
                pushing(ans1)
                popping()
            elif nums == '-':
                ans = float(popMat[0]) - float(popMat[1])
                ans1 = format(ans, '.3f')
                print(ans1)
                pushing(ans1)
                popping()
            elif nums == '*':
                ans = float(popMat[0]) * float(popMat[1])
                ans1 = format(ans, '.3f')
                print(ans1)
                pushing(ans1)
                popping()
            elif nums == '/':
                if float(firstMat[1]) != 0:
                    ans = float(popMat[0]) / float(popMat[1])
                    ans1 = format(ans, '.3f')
                    print(ans1)
                    pushing(ans1)
                    popping()
                else:
                    print('error: division by 0 ')
                    print(float(popMat[0]))

def popping():
    x = 0
    while x<3:
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



rpnProg()
