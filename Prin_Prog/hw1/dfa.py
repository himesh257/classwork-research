def dfa():

    first = input("")
    states = first.split()
    second = input("")
    symbols = second.split()
    longInput = {}    # dict with states
    longInput1 = []   # user entered rules
    seven = []
    p = 0
    m = 0
    while True:

        six = input()

        if six != 'end_rules' and six != 'begin_rules':
            longInput1.append(six.split())
            seven = six.split()

            if seven[0] not in longInput:
                longInput[seven[0]] = {seven[4]:seven[2]}
            else:
                #longInput.setdefault(seven[0],[]).append({seven[4]:seven[2]})
                longInput[seven[0]][seven[4]] = seven[2]
        if six == "end_rules":
            break


    third = input("")
    thirdONe = third.split('start: ',1)[1]
    four = input("")
    final = four.split('final: ',1)[1]
    final2 = final.split()
    h = 0
    finalState = ''
    one = []
    while True:
        try:
            test = input()
            a = accepts(longInput,thirdONe,final2,test)
            if a == True:
                print('accepted')
            else:
                print('rejected')
        except EOFError as error:
            break

def accepts(transitions, initial, accepting, s):
    try:
        state = initial
        for c in s:
            state = transitions[state][c]
        return state in accepting
    except KeyError as error:
        return False

dfa()
