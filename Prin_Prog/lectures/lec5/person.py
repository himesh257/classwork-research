class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def f(self):
        print("f in Person")

class Foo:
    def __init__(self):
        pass

    def f(self):
        print("f in Foo")

class Student(Person, Foo):
    def __init__(self, name, age, gpa):
        Person.__init__(self, name, age)
        Foo.__init__(self)
        self.gpa = gpa
