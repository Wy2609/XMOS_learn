/*
 * interface_function.xc
 *
 *  Created on: Jul 17, 2019
 *      Author: wangyon1
 */

#include <stdio.h>
#include <string.h>

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


interface my_interface_3 {
    int send_and_rec(int x);
    void fill_buffer(int buf[n], unsigned n);
};

void task5(client interface my_interface_3 i) {
    int re = i.send_and_rec(30);
    int a[5];
    printf("\nThe sever send to client %d.\n", re);
    i.fill_buffer(a, 5);
    printf("The server fill buffer with: %d\n", a[1]);

}

void task6(server interface my_interface_3 i) {
    int data[5] = {100, 200, 400, 600, 800};
    while (1) {
    select {
        case i.send_and_rec(int x) -> int ret:
               ret = 10000;
               printf("The client send %d to server.\n", x);
               break;
        case i.fill_buffer(int a[n], unsigned n):
                memcpy(a, data, n*sizeof(int));
                break;
    }
    }
}



int main()
{
    interface my_interface i;
    interface my_interface_2 i2;
    interface my_interface_3 i3;
    par {
        task1(i);
        task2(i);
    }

    par {
        task3(i2);
        task4(i2);
    }

    par {
        task5(i3);
        task6(i3);
    }

    return 0;
}

