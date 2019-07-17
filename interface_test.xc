/*
 * interface_test.xc
 *
 *  Created on: Jul 17, 2019
 *      Author: wangyon1
 */
#include <stdio.h>
#include <print.h>


char name[] = "YongWang";
int arr[] = {9,2,3,6};

// tool functions

void print_char(const char *p , int len) {
    for (int i = 0; i < len; i++)
        printf("%c ", *(p+i));
}

void print_int(int arr[], int len)
{
    for (int i = 0; i < len; i++)
        printf("%d ", arr[i]);
}


interface my_interface {
    void fA(char *p, int len);
    void fB(int a, int size);
};


// using client end to send data
void task_client1(client interface my_interface c)
{


    c.fB(5, 4);
    c.fA(name, 9);


}

void task_client2(client interface my_interface c)
{
    c.fB(7, 4);
}


//using server end to receive data
void task_server(server interface my_interface s) {
    select {
    case s.fA(char *p, int len):
        printf("The string is %s, and the len is %d\n", p, len);
        break;
    case s.fB(int a, int size):
        printf("The arr is %d,The len is: %d\n", a, size);
        break;
    }

}


int main()
{
    interface my_interface i1;
    //interface my_interface i2;

    par {
        task_client1(i1);
        task_server(i1);
    }



    return 0;
}
