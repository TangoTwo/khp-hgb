cmake_minimum_required(VERSION 3.12)
project(team C)

set(CMAKE_C_STANDARD 11)

add_executable(team main.c stackoperm.c stackoperm.h main.h)
target_link_libraries(team m)