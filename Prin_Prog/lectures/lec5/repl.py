while True:
    s = input('> ')
    try:
        exec(f'print(repr({s}))')
    except TypeError:
        exec(s)
