#include <stdio.h>

interface my_interface {
    void fA(int x, int y);
    void fB(float x);
};

void task1(interface my_interface client c)
{
    c.fB(50);
    c.fA(5, 10);
}

void task2(interface my_interface server c)
{
    select {
        case c.fA(int x, int y):
            printf("Received fA: %d, %d.\n", x, y);
            break;
        case c.fB(float x):
            printf("Received fB: %f.\n", x);
            break;
    }
}

void task3(interface my_interface client c)
{
    c.fA(1000, 2000);
    c.fB(0.009);
}

void task4(interface my_interface server i1,
            interface my_interface server i2)
{
    while (1) {
        select {
            case i1.fA(int x, int y):
                  printf("Received fA on interface end i1: %d,%d\n", x,y);
                  break;
            case i1.fB(float x):
                printf("Received fB on interface end i1: %f\n", x);
                break;
            case i2.fA(int x, int y):
                printf("Received fA on interface end i2: %d, %d\n", x, y);
                break;
            case i2.fB(float x):
                printf("Received fB on interface end i2: %f\n", x);
                break;
        }
    }
}


int main()
{
    interface my_interface i1;
    interface my_interface i2;
    par {
        task1(i1);
        task3(i2);
        task4(i1, i2);
    }
    return 0;
}
