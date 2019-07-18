/*
 * selectFunc.xc
 *
 *  Created on: Jul 18, 2019
 *      Author: wangyon1
 */

#include <print.h>
#include <xs1.h>



void task(chanend c)
{
    c <: 20;
}


select my_case(chanend c, timer t, unsigned timeout) {
    case c :> int x:
        printintln(x);
        break;
    case t when timerafter(timeout) :> void:
        printstrln("Timeout");
        timeout += 100000;
        break;
}

int main()
{
    timer tmr;
    unsigned timeout ;
    tmr :> timeout;
    timeout += 10000;
    chan c;

    par {
        task(c);
        my_case(c,tmr,timeout);
    }

    return 0;

}
