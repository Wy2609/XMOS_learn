/*
 * channel_server_client.xc
 *
 *  Created on: Jul 22, 2019
 *      Author: wangyon1
 */

#include <platform.h>
#include <stdio.h>

#define PERIOD 50000
timer tmr;
unsigned time;

int snd[10], rcv[10];

int main(void)
{
    chan c;

    par {
        on stdcore[0] : master {
            tmr :> time;
            for (int i = 0; i < 10; i++) {
                snd[i] = i * 4;
                time += PERIOD;
                tmr when timerafter(time) :> void;
                c <: snd[i];
                printf("##Master send %d\n", snd[i]);
            }
        }
        on stdcore[1] : slave {
            for (int i = 0; i < 10; i++) {
                c :> rcv[i];
                printf("**Slave received %d\n", rcv[i]);
            }

        }
    }
}




