class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
        self.occupation = 'unemployed'

    def hello(self):
        print(self.name + ' says hello')

p1 = Person('bob', 20)
print(p1.occupation)
p1.hello()
