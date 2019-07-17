/*
 * combinable_func.xc
 *
 *  Created on: Jul 17, 2019
 *      Author: wangyon1
 */

#include <stdio.h>
#include <timer.h>
#include <syscall.h>
#include <print.h>
#include <xs1.h>
#include <platform.h>

[[combinable]]
void counter_task(const char *taskId) {
    int count = 0;
    timer tmr;
    unsigned time;
    tmr :> time;

    while (1) {
        select {
            case tmr when timerafter(time) :> int now:
                count++;
                time += 100000;
                printf("%s task get selected. counter = %d\n", taskId, count);
                break;
        }
    }
}

[[combinable]]
 void counter_task2(const char *taskId) {
    timer tmr2;
    unsigned time2;
    int counter2 = 0;
    tmr2 :> time2;

    while (1) {
        select {
            case tmr2 when timerafter(time2) :> int now:
                counter2++;
                time2 += 500000;
                printf("%s task get selected,counter2 = %d.\n", taskId, counter2);
                break;
        }
    }
}

int main()
{
    par {
        on tile[0].core[0]: counter_task("task1");
        on tile[0].core[0]: counter_task("task2");
    }
    return 0;
}



