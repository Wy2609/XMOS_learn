/*
 * AntiSerial.xc
 *
 *  Created on: Jul 23, 2019
 *      Author: wangyon1
 */

#include <xs1.h>

in  buffered port:8  inP = XS1_PORT_4A;
out          port   outClock = XS1_PORT_1A;
clock               clk25 = XS1_CLKBLC_1;

int main(void)
{
    configure_clock_rate(clk25, 100, 4);
    configure_in_port(inP, clk25);
    configure_port_clock_output(outClock, clk25);
    statr_clock(clk25);

    while (1) {
        int x;
        inP :> x;
        f(x);
    }
}
