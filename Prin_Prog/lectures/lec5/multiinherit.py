class A:
    def f(self):
        return 10 + self.g()

class B:
    def g(self):
        return 42

class C(A,B):
    pass
