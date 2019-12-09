#!/bin/bash

red() {
    echo -e "\e[31m${1}\e[0m"
}

red "Going to compile the following program:"
set -x
cat program1.cc
cat program2.cc
cat main.cc
set +x

red "Compiling the program in debug mode. All the messages should be strings"
FLAGS=-DDEBUG
g++-9 -c -std=c++2a $FLAGS program1.cc -O3 -o program1.o
g++-9 -c -std=c++2a $FLAGS program2.cc -O3 -o program2.o
g++-9 -std=c++2a $FLAGS main.cc -O3 program1.o program2.o -o main-debug
red "running:"
./main-debug
echo

red "Compiling the program that creates a map between the strings and the crc32:"
FLAGS=-DCREATE_MAP
g++-9 -c -std=c++2a $FLAGS program1.cc -O3 -o program1.o
g++-9 -c -std=c++2a $FLAGS program2.cc -O3 -o program2.o
g++-9 -std=c++2a $FLAGS crc_to_string.cc -O3 program1.o program2.o -o crc_to_string
red "Running the program to see all the values"
./crc_to_string
echo

red "Compiling the program in release mode. All the messages should be crc32 of the string"
unset FLAGS
g++-9 -c -std=c++2a $FLAGS program1.cc -O3 -o program1.o
g++-9 -c -std=c++2a $FLAGS program2.cc -O3 -o program2.o
g++-9 -std=c++2a $FLAGS main.cc -O3 program1.o program2.o -o main-release
strip main-release
./main-release
echo

red "Searching for the strings in the binary:"
set -x
strings main-release | grep -i "error\|system"
