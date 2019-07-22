/*
 * concurrent1.xc
 *
 *  Created on: Jul 22, 2019
 *      Author: wangyon1
 */

#include <platform.h>

on stdcore[0] : out port tx = XS1_PORT_1A;
on stdcore[0] : in  port rx = XS1_PORT_1B;
on stdcore[1] : out port lcdData = XS1_PORT_32A;
on stdcore[2] : in  port keys    = XS1_PORT_8B;

void uartTX(out port TX)
{}
void uartRX(in port RX)
{}
void lcdDrive(out port lcd)
{}
void kbListen(in port KEY)
{}

int main(void)
{
    par {
        on stdcore[0] : uartTX(tx);
        on stdcore[0] : uartRX(rx);
        on stdcore[1] : lcdDrive(lcdData);
        on stdcore[2] : kbListen(keys);
    }
}
