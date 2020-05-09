def get_first_name(full_name):
    return full_name.split(" ")[0]

defaults = {
    "name": "Bob Jones",
    "address": "123 Main St."
}

raw_name = input("Please enter your name: ")
first_name = get_first_name(raw_name)

# If the user didn't type anything in, use the fallback name
if not first_name:
    first_name = get_first_name(defaults)

print(f"Hi, {first_name}!")
