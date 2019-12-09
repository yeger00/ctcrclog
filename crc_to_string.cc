#include <iostream>
#include <map>
#include "ctcrclog.hpp"

std::map<uint32_t, std::string>& crc_to_string = CrcToStringMap::get_crc_to_string();

int main() {
	std::map<uint32_t, std::string>::iterator it;
    
        for (it=crc_to_string.begin(); it != crc_to_string.end(); it++) {
                std::cout << it->first << " : " << it->second << std::endl;
	}
        return 0;
}
