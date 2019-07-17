/*
 * interface_function.xc
 *
 *  Created on: Jul 17, 2019
 *      Author: wangyon1
 */

#include <stdio.h>

interface my_interface {
    int get_value(int c_to_s);
};

void task1(client interface my_interface i) {
    int x;
    x = i.get_value(100);
    printf("Server send %d to client.\n", x);
    //printintln(x);
}

void task2(server interface my_interface i) {
    int data = 33;
    select {
        case i.get_value(int c_to_s) -> int return_val:
            printf("Client send %d to server\n", c_to_s);
            return_val = data + c_to_s;
            break;
    }
}

interface my_interface_2 {
    void f(int a[], int len);
};

void task3(client interface my_interface_2 i) {
    int a[5] = {0, 1, 2, 3, 4};
    i.f(a, 5);
}

void task4(server interface my_interface_2 i) {
    select {
        case i.f(int a[], int len) :
            for (int i = 0; i < len; i++)
                printf("%d ", a[i]);
            break;
    }
}






int main()
{
    interface my_interface i;
    interface my_interface_2 i2;
    par {
        task1(i);
        task2(i);
    }

    par {
        task3(i2);
        task4(i2);
    }


    return 0;
}

