class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
#        self.occupation = 'unemployed'

p1 = Person('bob', 20)
if p1.age > 30:
    print(p1.occupation)
