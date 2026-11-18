#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define SENSORS 2

extern void _setbit(unsigned char*,unsigned char);
extern unsigned char _getbit(unsigned char,unsigned char);
void update_temp( int *temps);
void update_flags( int *temps,int *last_temps, unsigned char *flags);
void print_flag(unsigned char flags);

int main(void)
{
	srand(time(NULL));
	int temps[SENSORS] = {25,25};
	int last_temps[SENSORS] = {25,25};
	unsigned char flags[SENSORS] = {0b00000001,0b00000001};

	printf("\n\r SENSOR 1: ~%d °C",temps[0]);
	print_flag(flags[0]);
	printf("\n\r SENSOR 2: ~%d °C",temps[1]);
	print_flag(flags[1]);

	update_temp(last_temps),
	printf("\n\r SENSOR 1: ~%d °C",last_temps[0]);
	printf("\n\r SENSOR 2: ~%d °C",last_temps[1]);


	printf("\n\rFIN DE PROGRAMA\n\n\r");
	return 0;
}




void update_temp( int *temps)
{
	int min = -5,max = 5;
	for(int i = 0 ; i < SENSORS; i++)
	{
		temps[i]+=rand() % (max - min + 1) + min;
	}
}


void print_flag(unsigned char flag)
{
	printf("-");
}