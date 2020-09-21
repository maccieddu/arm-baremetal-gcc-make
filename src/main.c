#include "main.h"
#include "add.h"
#include "itm.h"

float i = 1.0f;
float j = 2.0f;
float k = 0.0f;

int arr[] = { 1, 10, 4, 5, 6, 7 };

const int c = 1;
const int cc = 2;

void main(void)
{
    int d = COUNT;

    d = add(1, 2);
    while(1)
    {
        k = i / j;
        k = add(arr[0], arr[1]);
        ITM_SendChar((unsigned char)d);
        ITM_SendChar('a');
        ITM_SendChar('\n');
    }
}
