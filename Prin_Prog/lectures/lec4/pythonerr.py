def foo(x):
    return x % 47 + 80

my_variable = 10
while my_variable > 0:
    i = foo(my_variable)
    if i < 100:
        my_variable += 1
    else:
        my_varaible = (my_variable + i) / 10
