/*
 * channel_array.xc
 *
 *  Created on: Jul 17, 2019
 *      Author: wangyon1
 */


#include <stdio.h>
#include <string.h>



void task_1(chanend c) {
     c <: 99;
}

void task_2(chanend c) {
    c <: 100;
}

void task_3(chanend c[n], unsigned n)
{
    while (1) {
    select {
        case c[int i] :> int value:
            printf("conenction %d send %d.\n", i, value);
            break;
    }
    }

}

int main()
{
    chan c[2];

    par {
        task_1(c[0]);
        task_2(c[1]);
        task_3(c, 2);
    }

    return 0;
}
