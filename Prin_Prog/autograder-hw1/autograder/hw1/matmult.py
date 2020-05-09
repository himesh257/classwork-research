def mult():
    first = input()
    firstRowMat = []
    secondRowMat = []
    firstMat = first.split()
    x = 0
    while x < int(firstMat[0]):
        firstRow = input()
        firstRowMat.append(firstRow.split())
        x += 1

    newArr = ([[int(y) for y in x] for x in firstRowMat])

    second = input()
    secondMat = second.split()
    y = 0
    while y < int(secondMat[0]):
        secondRow = input()
        secondRowMat.append(secondRow.split())
        y += 1

    newArr1 = ([[int(y) for y in x] for x in secondRowMat])


    newOne = first[2]
    newTwo = second[0]
    newThree = first[0]
    newFour = second[2]
    zeroTwo = '0'
    result = []
    zero = []

    if newOne == newTwo:
        p = 0
        q = 0
        while q < int(newFour):
            zero.append(zeroTwo)
            q += 1
        while p < int(newThree):
            result.append(zero)
            p += 1
        newArr2 = ([[int(y) for y in x] for x in result])
        for i in range(len(newArr)):
            for j in range(len(newArr1[0])):
                for k in range(len(newArr1)):
                    newArr2[i][j] += (newArr[i][k]) * (newArr1[k][j])

        h = 0
        l = 0
        print(newArr2[0])

        while h < int(newFour):
            l = 0
            while l < int(newFour):
                print(newArr2[h][l], end=' ')
                l += 1
            h += 1

    else:
        print('Error')

    #newArr3 = [int(y) for x in newArr2 for y in x]
    #print(newArr3)

    """
    while l < int(newFour):
        while h < int(newFour):
            print(newArr3[h], end=" ")
            h+=1
        newArr3.pop(0)
        l +=1

    print()
    for r in newArr3:
        print(r, end=" ")
    """
mult()

