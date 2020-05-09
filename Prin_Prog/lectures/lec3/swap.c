#include <stdio.h>

void swap(int* x, int* y)
{
    int tmp = *x;
    *x = *y;
    *y = tmp;
}

int main(char* args[])
{
    int a = 10;
    int b = 20;
    swap(&a, &b);
    printf("%d, %d\n", a, b);
}
