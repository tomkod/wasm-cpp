cmake_minimum_required (VERSION 2.6)
project (thread_test)

set (CMAKE_CXX_STANDARD 14)
set (CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++ -pthread")

add_executable(run_test thread_test.cpp)

