cmake_minimum_required(VERSION 3.10)
project(cgb)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(compile_flags INTERFACE)

set(OpenGL_GL_PREFERENCE GLVND)

find_package(OpenGL REQUIRED)
find_package(GLUT REQUIRED)

include_directories( ${OPENGL_INCLUDE_DIRS}  ${GLUT_INCLUDE_DIRS})

# Übungsbeispiel 1
# ----------------
file(GLOB_RECURSE BSP1 "src/main.cpp")
# matrix
add_executable(simon ${BSP1})
target_link_libraries(simon compile_flags ${OPENGL_LIBRARIES} ${GLUT_LIBRARY})

# Übungsbeispiel 1
# ----------------
file(GLOB_RECURSE BSP2 "src/main2.cpp")
# matrix
add_executable(labyrinth ${BSP2})
target_link_libraries(labyrinth compile_flags ${OPENGL_LIBRARIES} ${GLUT_LIBRARY})