#include <iostream>
#include "ctcrclog.hpp"

void OnError() {
	std::cout << Message<FixedString("Error occured")>().get_message() << std::endl;
}
