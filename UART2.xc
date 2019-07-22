/*
 * UART_2.xc
 *
 *  Created on: Jul 22, 2019
 *      Author: wangyon1
 */


#include <xs1.h>

#define BIT_RATE 115200
#define BIT_TIME 100000000 / BIT_RATE

out port TXD = XS1_PORT_1A;
in port RXD = XS1_PORT_1B;

void transmitter(out port TXD) {
    unsigned byte, time;
    timer t;

    while (1) {
        byte = getByte();
        t :> time;

        TXD <: 0;
        time += BIT_TIME;
        t when timerafter(time) :> void;

        for (int i = 0; i < 8; i++) {
            TXD <: >> byte;
            time += BIT_TIME;
            t when timerafter(time) :> void;
        }

        TXD <: 1;
        time += BIT_TIME;
        t when timerafter(time) :> void;
    }
}

void receiver(in port RXD)
{
    unsigned byte, time;
    timer t;

    while (1) {

        // RXD port wait until 0 received.
        RXD when pinseq(0) :> void;
        t :> time;
        time += BIT_TIME/2;

        for (int i = 0; i < 8; i++) {
            time += BIT_TIME;
            t when timerafter(time) :> void;
            RXD :> >> byte;
        }

        time += BIT_TIME;
        t when timerafter(time) :> void;
        RXD :> void;
        putByte(byte >> 24);
    }
}




