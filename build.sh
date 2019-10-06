#!/bin/bash
set -x

FLAGS=-DDEBUG
g++-9 -c -std=c++2a $FLAGS program.cc -O3 -o program.o
g++-9 -std=c++2a $FLAGS main.cc -O3 program.o -o main-debug
./main-debug
echo

FLAGS=-DCREATE_MAP
g++-9 -c -std=c++2a $FLAGS program.cc -O3 -o program.o
g++-9 -std=c++2a $FLAGS crc_to_string.cc -O3 program.o -o crc_to_string
./crc_to_string
echo

unset FLAGS
g++-9 -c -std=c++2a $FLAGS program.cc -O3 -o program.o
g++-9 -std=c++2a $FLAGS main.cc -O3 program.o -o main-release
strip main-release
./main-release
echo

strings main-release | grep -i "error\|system"
