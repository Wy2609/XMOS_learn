/*
 * butten_test.xc
 *
 *  Created on: Jul 18, 2019
 *      Author: wangyon1
 */

#include <xs1.h>
#include <platform.h>
#include <stdio.h>

in port p = XS1_PORT_1B;


[[combinable]]
 void task1(in port p)
{
    int current_val = 0;
    int is_stable = 1;
    timer tmr;
    const unsigned debounce_delay_ms = 50;
    unsigned debunce_timeout ;

    while (1) {
        select {
            case p when pinsneq(current_val) :> int current_val:
                if (new_val == 1) {
                    printf("Butten up!\n");
                } else {
                    printf("Butten down!\n");
                }
                is_stable = 0;
                tmr :> current_time;
                debunce_timeout = current_time + (debunce_delay_ms * XS1_TIMER_HZ);
                break;
            case !is_table => tmr when timerafter(dobunce_timeout) :> void:
                    is_stable = 1;
                    break;
        }
    }
}

int main()
{
    par {
        task1(p);
    }
    return 0;
}
