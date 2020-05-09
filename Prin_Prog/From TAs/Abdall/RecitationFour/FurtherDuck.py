#person = {'name': 'Jeff', 'age': 23, 'occupation': 'professor'}
person = {'name': 'Jeff', 'age': 23}


# if 'name' in person and 'age' in person and 'occupation' in person:
#     print("Hello I'm {name}, I am {age} years old, and I am a {occupation} for a living".format(**person))
# else:
#     print("Missing some keys")


try:
    print("Hello I'm {name}, I am {age} years old, and I am a {occupation} for a living".format(**person))
except KeyError as e:
    print("Missing {} key".format(e))
