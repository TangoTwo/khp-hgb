cmake_minimum_required(VERSION 3.10)
project(chess)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(compile_flags INTERFACE)
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    target_compile_options(compile_flags INTERFACE -Wall -Wextra -Wpedantic -Wconversion)
endif ()

file(GLOB_RECURSE SOURCES "chess/*")
add_executable(chess ${SOURCES})
target_link_libraries(chess compile_flags)
