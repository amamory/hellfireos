#include <hellfire.h>
//#include <libc.h>
//#include <task.h>
//#include <stdint.h>


int i=0;

void task(){
   printf("Hello # %d !!\n", i);
   i++;
}

void app_main(void)
{
	hf_spawn(task, 0, 0, 0, "task", 2048);
}
