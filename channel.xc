/*
 * channel.xc
 *
 *  Created on: Jul 17, 2019
 *      Author: wangyon1
 */

#include <stdio.h>
#include <print.h>

const int a[] = {0,9,2,6};

void task1(chanend c) {
    for (int i = 0; i < 4; i++)
    {
        c <: a[i];
    }
}

void task2(chanend c) {
    while (1) {
    select {
        case c :> int i:
            printintln(i);
            break;
    }
    }
}

int main()
{
    chan c;
    par {
        task1(c);
        task2(c);
    }
    return 0;
}


