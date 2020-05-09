typedef struct Person
{
    char* name;
    int age;
} Person;

void growOlder(Person* p)
{
    p->age += 1;
}
