set(CMAKE_CXX_FLAGS "-Wall -Wextra -O3 -s")

add_executable (example main.cpp src/on_error.cpp src/system_up.cpp)
add_executable (crc_to_string crc_to_string.cpp src/on_error.cpp src/system_up.cpp)

# Add the -DCREATE_MAP flag in order to compile the target with this feature.
target_compile_options(crc_to_string PRIVATE -DCREATE_MAP)

target_link_libraries (example CTCrcLog)
target_link_libraries (crc_to_string CTCrcLog)
