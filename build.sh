#!/bin/bash

red() {
    echo -e "\e[31m${1}\e[0m"
}

red "Going to compile the following program:"
set -x
cat examples/program1.cpp
cat examples/program2.cpp
cat examples/main.cpp
set +x

red "Compiling the program in debug mode. All the messages should be strings"
FLAGS="-DDEBUG -Iinclude"
g++-9 -c -std=c++2a $FLAGS examples/program1.cpp -O3 -o program1.o
g++-9 -c -std=c++2a $FLAGS examples/program2.cpp -O3 -o program2.o
g++-9 -std=c++2a $FLAGS examples/main.cpp -O3 program1.o program2.o -o main-debug
red "running:"
./main-debug
echo

red "Compiling the program that creates a map between the strings and the crc32:"
FLAGS="-DCREATE_MAP -Iinclude"
g++-9 -c -std=c++2a $FLAGS examples/program1.cpp -O3 -o program1.o
g++-9 -c -std=c++2a $FLAGS examples/program2.cpp -O3 -o program2.o
g++-9 -std=c++2a $FLAGS examples/crc_to_string.cpp -O3 program1.o program2.o -o crc_to_string
red "Running the program to see all the values"
./crc_to_string
echo

red "Compiling the program in release mode. All the messages should be crc32 of the string"
FLAGS="-Iinclude"
g++-9 -c -std=c++2a $FLAGS examples/program1.cpp -O3 -o program1.o
g++-9 -c -std=c++2a $FLAGS examples/program2.cpp -O3 -o program2.o
g++-9 -std=c++2a $FLAGS examples/main.cpp -O3 program1.o program2.o -o main-release
strip main-release
./main-release
echo

red "Searching for the strings in the binary:"
set -x
strings main-release | grep -i "error\|system"
