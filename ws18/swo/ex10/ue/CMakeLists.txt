cmake_minimum_required(VERSION 3.12)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(compile_flags INTERFACE)
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
   target_compile_options(compile_flags INTERFACE -Wall -Wextra -Wpedantic -Wconversion)
endif()

file(GLOB_RECURSE rm "resourceManager/*")
add_executable(resourceManager ${rm})
target_link_libraries(resourceManager compile_flags)

file(GLOB_RECURSE simpleVector "simpleVect/*")
add_executable(simpleVector ${simpleVector})
target_link_libraries(simpleVector compile_flags)

file(GLOB_RECURSE vector "vector/*")
add_executable(vector ${vector})
target_link_libraries(vector compile_flags)
