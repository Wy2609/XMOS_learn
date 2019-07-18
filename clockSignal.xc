/*
 * clockSignal.xc
 *
 *  Created on: Jul 18, 2019
 *      Author: wangyon1
 */

#include <xs1.h>

out port p_out = XS1_PORT_8A;
out port p_clock_out = XS1_PORT_1A;
clock clk = XS1_CLKBLK_1;

int main(void)
{
    // configure the clock clk to have a rate of 12.5MHz, The rate is specified as a
    //fraction(100MHz/8) because xC only supports interger arithmetic types.
    configure_clock_rate(clk, 100, 8);

    // configures the output port p_out to be clocked by the clock clk, with an initial
    // value of 0 dirven on its pin.
    configure_out_port(pout, clk, 0);

    // causes the clock signal clk to be driven on the pin connected to the port
    // p_clock_out, which a receiver can use to sample the data driven by the port p_out.
    configure_port_clock_output(p_clock_out, clk);

    // causes the clock block to start producing edges
    start_clock(clk);

    for (int i = 0; i < 5; i++)
        p_out <: i;

    return 0;
}
