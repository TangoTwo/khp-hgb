cmake_minimum_required(VERSION 3.0)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

add_library(compile_flags INTERFACE)

if("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
   target_compile_options(compile_flags INTERFACE -Wall -Wextra -Wpedantic -Wconversion -Werror=vla)
endif()

# Übungsbeispiel 1
# ----------------
file(GLOB_RECURSE BSP1 "adt/*")
add_executable(adt ${BSP1})
target_link_libraries(adt compile_flags)

# Übungsbeispiel 2
# ----------------
file(GLOB_RECURSE BSP2 "top/*")
add_executable(top ${BSP2} adt/al_adt.c)
target_link_libraries(top compile_flags -lm)
