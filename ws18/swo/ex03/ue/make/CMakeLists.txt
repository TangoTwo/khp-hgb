cmake_minimum_required(VERSION 3.0)

set(CMAKE_C_STARDARD 11)
set(CMAKE_C_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

if("${CMAKE_COMPILER_ID}" STREQUAL "GNU")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Wpedantic -Wconversion -Werror=vla")
endif()
# set (SRC geo/prg.c geo/weight.c geo/geo.c)
file(GLOB SRC geo/*.c)
add_executable(prg ${SRC})