#include <stdio.h>

int main(int argc, char ** argv)
{
	const char * name = "unknown";
	if(argc >= 2){
		name = argv[1];
	}
	printf("Hello '%s'!\n", name);
	return 0;
}
