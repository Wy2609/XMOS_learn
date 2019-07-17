/*
 * interface_array.xc
 *
 *  Created on: Jul 17, 2019
 *      Author: wangyon1
 */

// using interface array to build communication between one task to many tasks.

#include <stdio.h>
#include <string.h>

interface my_interface {
    void talk(int x);
};

void task_c(client interface my_interface i, int id) {
    i.talk(id);
}

void task_s(server interface my_interface a[n], unsigned n) {
    while (1) {
        select {
            case a[int i].talk(int x):
                 printf("Received %d from connection %d.\n", x, i);
                 break;
        }
    }
}

int main()
{
    interface my_interface a[5];
    par {
        task_c(a[0], 10);
        task_c(a[1], 11);
        task_c(a[2], 12);
        task_c(a[3], 13);
        task_c(a[4], 14);
        task_s(a, 5);
    }
    return 0;
}
