cmake_minimum_required(VERSION 3.10)
project(swo)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(compile_flags INTERFACE)
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    target_compile_options(compile_flags INTERFACE -Wall -Wextra -Wpedantic -Wconversion)
endif()

file(GLOB_RECURSE WMB "wmb/*")
add_executable(wmb ${WMB})
target_link_libraries(wmb compile_flags)

file(GLOB_RECURSE ADT "adt/*")
add_executable(adt ${ADT})
target_link_libraries(adt compile_flags)




