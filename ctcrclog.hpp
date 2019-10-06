#ifndef __CTCRCLOG_HPP__
#define __CTCRCLOG_HPP__

#include <iostream>
#include <map>
#include <type_traits>
#include "ctfixed_string.hpp"
#include "ctcrc.hpp"

// Compile with and without -DDEBUG
#ifdef DEBUG
struct is_debug : public std::true_type { };
#else
struct is_debug : public std::false_type { };
#endif

// Compile with and without -DCREATE_MAP
#ifdef CREATE_MAP
struct is_create_map : public std::true_type { };
#else
struct is_create_map : public std::false_type { };
#endif


std::map<uint32_t, std::string> crc_to_string;


template<typename Q=is_create_map>
class AddToMap {
public:
	AddToMap(const char * str) {
		add_to_map(str);
	}
	// In debug will add the crc and the string to the map
	template<typename L = Q>
	typename std::enable_if<L::value>::type
	add_to_map(const char * str) {
		crc_to_string[crc32(str)] = std::string(str);
	}
	// In release does nothing
	template<typename L = Q>
	typename std::enable_if<!L::value>::type
	add_to_map(const char * str) {
	}
};


template<auto T, typename Q=is_debug>
class Message {
        static constexpr char const* message = T;
public:
        static AddToMap<is_create_map> adder;
        Message() {
		// Dummy call so it will call the c'tor.
		adder;
	};

	// In debug will return the message itself.
	template<typename L = Q>
	constexpr typename std::enable_if<L::value, char>::type const *
        get_message() const {
		return message;
	};
	// In release will return the crc of the message.
	template<typename L = Q>
	constexpr typename std::enable_if<!L::value, uint32_t>::type const
        get_message() const {
		return crc32(message);
	};
};

template<auto T, typename Q>
AddToMap<is_create_map> Message<T, Q>::adder = AddToMap(T);

#endif // __CTCRCLOG_HPP__
