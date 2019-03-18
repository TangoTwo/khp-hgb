cmake_minimum_required(VERSION 3.12)
project(ex01)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib/static)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_subdirectory(ml5) #NOTE: there should be a local folder "ml5" next to the source folders that contains the ML5 distribution

find_package(wxWidgets COMPONENTS gl core base REQUIRED)

include(${wxWidgets_USE_FILE})

file(GLOB_RECURSE DEMO "intro/src/*")
add_executable(intro ${DEMO})
target_link_libraries(intro minilib)

file(GLOB_RECURSE DEMO "list/src/*")
add_executable(list ${DEMO})
target_link_libraries(list minilib)

file(GLOB_RECURSE DEMO "draw/src/*")
add_executable(draw ${DEMO})
target_link_libraries(draw minilib)

file(GLOB_RECURSE DEMO "asteroids/*")
add_executable(asteroids ${DEMO} asteroids/drawables/drawable.h asteroids/drawables/asteroid.h)
target_link_libraries(asteroids minilib)
