/*
 * replicatedtimer.xc
 *
 *  Created on: Jul 18, 2019
 *      Author: wangyon1
 */


#include <platform.h>
#include <xs1.h>
#include <timer.h>
#include <stdio.h>

timer tmr_array[5];
unsigned  timeout[5];
unsigned  period[5];

int main()
{
    for (size_t i = 0; i < 5; i++) {
        tmr_array[i] :> timeout[i];
        period[i]  = 100000;
    }

    while (1) {
    select {
        case (size_t i = 0; i < 5; i++)
                tmr_array[i] when timerafter(timeout[i]) :> void:
                    timeout[i] += period[i];
                    printf("timer %d got selected.\n", i);
                    break;
    }
    }

    return 0;
}
