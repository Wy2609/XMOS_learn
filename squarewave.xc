/*
 * squareWave.xc
 *
 *  Created on: Jul 23, 2019
 *      Author: wangyon1
 */


#include <xs1.h>
#include <platform.h>
#include <timer.h>

out buffered port:1 toggle = XS1_PORT_1B;
in           port  inClock = XS1_PORT_1C;
clock                  clk = XS1_CLKBLK_1;

int main(void)
{
    int count;

    configure_clock_src(clk, inClock);
    configure_out_port_no_ready(toggle, clk, 0);
    start_clock(clk);

    toggle <: 0 @ count;
    while (1) {
        count += 3;
        toggle @ count <: 1;
        count += 2;
        toggle @ count <: 0;
    }
    return 0;
}
