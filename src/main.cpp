#include <iostream>

int main(int argc, char ** argv)
{
	const char * name = "unknown";
	if(argc >= 2){
		name = argv[1];
	}
	std::cout<<"Hello '"<<name<<"'!"<<std::endl;
	return 0;
}
