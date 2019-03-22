cmake_minimum_required(VERSION 3.0)
project(cgb_01)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

add_library(compile_flags INTERFACE)

if("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
   target_compile_options(compile_flags INTERFACE -Wall -Wextra -Wpedantic -Wconversion -Werror=vla)
endif()

set(OpenGL_GL_PREFERENCE GLVND)

find_package(OpenGL REQUIRED)
find_package(GLUT REQUIRED)

include_directories( ${OPENGL_INCLUDE_DIRS}  ${GLUT_INCLUDE_DIRS} )
# Übungsbeispiel 1
# ----------------
file(GLOB_RECURSE BSP1 "src/*")
# matrix
add_executable(simon ${BSP1} ${amSrc})
target_link_libraries(simon compile_flags ${OPENGL_LIBRARIES} ${GLUT_LIBRARY})