class Duck:
    def fly(self):
        print('Duck flying')

class Airplane:
    def fly(self):
        print('Airplane flying')

def lift_off(entity):
    entity.fly()

duck = Duck()
airplane = Airplane()

lift_off(duck)     # prints `Duck flying`
lift_off(airplane) # prints `Airplane flying`
