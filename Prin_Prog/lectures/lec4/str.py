class Foo:
    def __init__(self):
        self.x = 10

    def __str__(self):
        return 'This object has x = ' + str(self.x)

f = Foo()
s = str(f)
print(s)
