/*
 * led_driver.xc
 *
 *  Created on: Jul 16, 2019
 *      Author: wangyon1
 */

#include <platform.h>
#include <xs1.h>
#include <timer.h>

on tile[3]: out port led_2 = XS1_PORT_1A;
on tile[3]: out port led_3 = XS1_PORT_1B;
on tile[3]: out port led_4 = XS1_PORT_1E;
on tile[3]: out port led_5 = XS1_PORT_1F;

void task(out port p, unsigned t_sec)
{
    while (1) {
        p <: 0;
        delay_seconds(t_sec);
        p <: 1;
        delay_seconds(t_sec);
    }
}

int main()
{
    par {
        on tile[3]: task(led_2, 1);
        on tile[3]: task(led_3, 2);
        on tile[3]: task(led_4, 3);
        on tile[3]: task(led_5, 4);
    }
    return 0;
}


