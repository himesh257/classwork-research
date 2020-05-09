from ctypes import cdll
lib = cdll.LoadLibrary('./libfoo.so')

def fact(n):
    return lib.factorial(n)

def main():
    print(fact(10))

if __name__ == '__main__':
    main()
