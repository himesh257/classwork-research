def mult():
    first = input()
    firstRowMat = []
    secondRowMat = []
    firstMat = first.split()
    x = 0
    while x < float(firstMat[0]):
        firstRow = input()
        firstRowMat.append(firstRow.split())
        x += 1

    newArr = ([[float(y) for y in x] for x in firstRowMat])

    second = input()
    secondMat = second.split()
    y = 0
    while y < float(secondMat[0]):
        secondRow = input()
        secondRowMat.append(secondRow.split())
        y += 1

    newArr1 = ([[float(y) for y in x] for x in secondRowMat])

    One = first.split()
    Two = second.split()
    newOne = One[1]
    newTwo = Two[0]
    newThree = One[0]
    newFour = Two[1]
    zeroTwo = '0'
    result = []
    zero = []

    if newOne == newTwo:
        p = 0
        q = 0
        while q < float(newFour):
            zero.append(zeroTwo)
            q += 1
        while p < float(newThree):
            result.append(zero)
            p += 1
        newArr2 = ([[float(y) for y in x] for x in result])
        for i in range(len(newArr)):
            for j in range(len(newArr1[0])):
                for k in range(len(newArr1)):
                    newArr2[i][j] += (newArr[i][k]) * (newArr1[k][j])
        newArr3 = [float(y) for x in newArr2 for y in x]
        h = 0
        l = 0
        while l < float(newFour):
            while h < float(newFour):
                print(newArr3[h], end=" ")
                h+=1
            newArr3.pop(0)
            l +=1

        print()
        for r in newArr3:
            print(r, end=" ")
    else:
        print('invalid input')

    #
    #print(newArr3)

    """

    """
mult()
