/*
 * timertest.xc
 *
 *  Created on: Jul 16, 2019
 *      Author: wangyon1
 */

#include <xs1.h>
#include <timer.h>
#include <platform.h>
#include <print.h>
#include <stdio.h>


void print_time(int taskId)
{
    timer t;
    unsigned t_start, t_end;
    for (int j = 0; j < 10000000; j++)
    { }
    t :> t_start;
    printf("The %d task start time is: %d.\n", taskId, t_start);
    for (int i = 0; i < 1000000; i++)
    {}
    t :> t_end;
    printf("The %d task end time is: %d.\n", taskId, t_end);
    printf("The time difference is: %d", t_end - t_start);

}

void time_select()
{
    timer t;
    unsigned time;
    const unsigned period = 100000;
    t :> time;
    while (1) {
        select {
            case t when timerafter(time) :> void:
                time += period;
                printf("The seconds: %u.\n", time);
                break;
        }
    }


}

int main()
{
    time_select();
    return 0;
}
