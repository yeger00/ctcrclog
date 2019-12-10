cmake_minimum_required (VERSION 3.12)
# First version to support C++20 is 3.12
project (CTCrcLog)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set (CXX_EXTENSIONS OFF)

add_library(CTCrcLog INTERFACE)
target_include_directories(CTCrcLog
  INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

add_subdirectory(examples)

if(BUILD_TESTING)
enable_testing()
add_subdirectory(tests)
endif()
