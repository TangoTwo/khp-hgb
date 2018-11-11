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
file(GLOB_RECURSE BSP1 "adt/test.c")
file(GLOB_RECURSE amSrc "adt/am_*")
file(GLOB_RECURSE alSrc "adt/al_*")
# matrix
add_executable(matrix ${BSP1} ${amSrc})
target_link_libraries(matrix compile_flags)
# list
add_executable(list ${BSP1} ${alSrc})
target_link_libraries(list compile_flags)
target_compile_definitions(list PUBLIC USE_LIST=1)

# Übungsbeispiel 2
# ----------------
file(GLOB_RECURSE BSP2 "top/*")
add_executable(top ${BSP1} ${alSrc} ${BSP2})
target_link_libraries(top compile_flags -lm)
target_compile_definitions(top PUBLIC USE_LIST=1 SORT=1)
