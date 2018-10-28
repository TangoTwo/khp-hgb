set(TARGET_NAME pipe)
project(${TARGET_NAME})

file(GLOB SRC *.c)
add_executable(${TARGET_NAME} ${SRC})