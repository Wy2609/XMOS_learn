/*
 * drive_LED.xc
 *
 *  Created on: Jul 18, 2019
 *      Author: wangyon1
 */

#include <xs1.h>
#include <platform.h>

on tile[3]:  port p = XS1_PORT_1A;

[[combinable]]
 void flashing_led_task2(port p, int delay_in_ms) {
    timer tmr;
    unsigned t;
    const int delay_ticks = delay_in_ms * 1000000;
    unsigned val = 0;

    tmr :> t;
    while (1) {
        select {
            case tmr when timerafter(t + delay_ticks) :> void:
                    p <: val;
                    val = ~val;
                    t += delay_ticks;
                    break;
        }

    }


}

int main()
{
    par {
        on tile[3]: flashing_led_task2(p, 1);
    }

    return 0;

}
