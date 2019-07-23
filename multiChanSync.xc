/*
 * mutilPortSync.xc
 *
 *  Created on: Jul 23, 2019
 *      Author: wangyon1
 */

#include <xs1.h>

out buffered port:4   p =  XS1_PORT_4A;
out buffered port:4   q  = XS1_PORT_4B;
in           port inClock = XS1_PORT_1A;
clock              clk    = XS1_CLKBLK_1;

int main()
{
    configure_clock_src(clk, inClock);
    configure_out_port(p, clk, 0);
    configure_out_port(q, clk, 0);
    start_clock(clk);

    p <: 0;
    sync(p);

    for (char c = 'A';  c <= 'Z'; c++) {
        p <: (c & 0xF0) >> 4;
        q <: (c & 0x0F);
    }
}


