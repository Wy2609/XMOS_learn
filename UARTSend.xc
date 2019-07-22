#include <xs1.h>
#include <stdio.h>

#define TXPERIOD 500000
#define RXPERIOD 500000

port rx = XS1_PORT_4A;
port tx = XS1_PORT_4B;

void putByte(unsigned i)
{
    printf("The received value is %d\n", i);
}

unsigned getByte()
{
    int n = 5;
    return n;
}

int isData()
{
    return 1;
}


void UART(port RX, int rxPeriod, port TX, int txPeriod) {
    int txByte, rxByte;
    int rxI, txI;
    int rxTime, txTime;
    int isTX = 0;
    int isRX = 0;
    timer tmrTX, tmrRX;

    while(1) {
        if (!isTX && isData()) {
            isTX = 1;
            txI = 0;
            txByte = getByte();
            TX <: 0;
            tmrTX :> txTime;
            txTime += txPeriod;
        }

        select {
            case !isRX => RX when pinseq(0) :> void:
                    isRX = 1;
                    tmrRX :> rxTime;
                    rxI = 0;
                    rxTime += rxPeriod;
                    break;
            case isRX => tmrRX when timerafter(rxTime) :> void:
                if (rxI < 8)
                    RX :> >> rxByte;
                else {
                    RX :> void;
                    putByte(rxByte >> 24);
                    isRX = 0;
                }
                rxI++;
                rxTime += rxPeriod;
                break;
            case isTX => tmrTX when timerafter(txTime) :> void:
                if (txI < 8)
                    TX <: txByte;
                else if(txI == 8)
                    TX <: 1;
                else
                    isTX = 0;
                txI++;
                txTime += txPeriod;
                break;
        }

    }

}

int main()
{
    par {
        UART(rx, RXPERIOD, tx, TXPERIOD);

    }
    return 0;
}
