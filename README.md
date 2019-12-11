# CTCrcLog #
This repository is an experimental repository for a Compile-Time CRC Log Library.
The library is an header-only library that enable the following:
1. Wrap every log message with the `Message<>()` template class provided by the library. E.g. std::cout << Message<FixedString("Error occured")>().get_message() << std::endl;
1. When compiling in debug (with `-DDEBUG` flag) the executable will print the string as is.
1. When compiling in release the executable will print the `crc32()` hash of the string. The strings won't be in the executable.
1. When compiling, another executable is created - `crc_to_string` - this executable contains a map between the `crc32()` values and the strings.

# Prerequists #
The library is using c++20 features, hence it requires a compiler that support it.

# How to compile and run the example #
```
mkdir build
cd build
cmake ../
# In case you need specific compiler use:
# CXX=/usr/bin/g++-9 cmake ../
make
```
Then, in the examples directory you will see two executables:
1. `example` - An example executable.
1. `crc_to_string` - An executable that contains a mapping between the `crc32()` values of the messages and the messages string.

```
$ cd examples
./crc_to_string 
2801838154 : System is up
3001801933 : Error occured

$ ./example 
2801838154
3001801933

$ grep -ai "System" ./example 
```

# How to contribute #
TBD

# License #
TBD
