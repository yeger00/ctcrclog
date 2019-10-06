#include <iostream>
#include <map>
//#include "ctcrclog.hpp"

extern std::map<uint32_t, std::string> crc_to_string;

int main() {
	std::map<uint32_t, std::string>::iterator it;
    
        for (it=crc_to_string.begin(); it != crc_to_string.end(); it++)
                std::cout << it->first << " : " << it->second << std::endl;
        std::cout << '\n';
        return 0;
}
