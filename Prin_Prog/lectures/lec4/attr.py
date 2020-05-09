class Attrs:
    def __getattribute__(self, a):
        print(f'Getting {a}')
        return object.__getattribute__(self, a)

    def __setattr__(self, k, v):
        print(f'Setting {k} to {v}')
        object.__setattr__(self, k, v)

attr = Attrs()
attr.x = 10
print(attr.x)
