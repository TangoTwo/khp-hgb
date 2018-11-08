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
file(GLOB_RECURSE BSP1 "preproc/*")
add_executable(preproc ${BSP1})
target_link_libraries(preproc compile_flags)

# Übungsbeispiel 2
# ----------------
file(GLOB_RECURSE BSP2 "struct/*")
add_executable(struct ${BSP2})
target_link_libraries(struct compile_flags)