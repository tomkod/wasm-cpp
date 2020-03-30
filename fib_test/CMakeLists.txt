cmake_minimum_required (VERSION 2.6)
project (fib_test)

set (CMAKE_CXX_STANDARD 14)
set (CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++")

add_library(fib_test STATIC fib_test.cpp)
add_executable(run_test fib_test)


