/*
 * SerialOutput.xc
 *
 *  Created on: Jul 23, 2019
 *      Author: wangyon1
 */

#include <xs1.h>

out buffered port:32 outP = XS1_PORT_8A;
in           port   inClock = XS1_PORT_1A;
clock                   clk = XS1_CLKBLK_1;

int main(void)
{
    int x = 0xAA00FFFF;
    configure_clock_src(clk, inClock);
    configure_out_port(outP, clk, 0);
    start_clock(clk);

    while (1) {
        outP <: x;
        x = x >> 8;
    }
}
