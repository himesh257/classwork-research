int factorial(int n)
{
    int rv = 1;
    for (int i = 2; i < n; i++)
        rv *= i;
    return rv;
}
