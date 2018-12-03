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
file(GLOB_RECURSE BSP1 "wmb/*")
add_executable(wmb ${BSP1})
target_link_libraries(wmb compile_flags)

# Übungsbeispiel 2
# ----------------
file(GLOB_RECURSE BSP2 "adt/*")
add_executable(adt ${BSP2})
target_link_libraries(wmb compile_flags -lm)
