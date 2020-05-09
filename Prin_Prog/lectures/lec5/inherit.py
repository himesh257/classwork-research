class A:
    def f(self):
        print("f in A called")

class B(A):
    def f(self):
        print("f in B called")

class C(A):
    def f(self):
        print("f in C called")

class D(B,C):
    pass
