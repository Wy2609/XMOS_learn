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

int main()
{
    interface my_interface i;
    par {
        task1(i);
        task2(i);
    }
    return 0;
}

