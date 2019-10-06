#include <iostream>
#include "ctcrclog.hpp"

bool SystemUp() {
	std::cout << Message<FixedString("System is up")>().get_message() << std::endl;
	return false;
}

void OnError() {
	std::cout << Message<FixedString("Error occured")>().get_message() << std::endl;
}
