cmake_minimum_required(VERSION 3.12)
project(fh_hgb C)

set(CMAKE_C_STANDARD 11)

add_executable(fh_hgb
        ws18/swo/ex01/asgmt/src/nova/main.c
        ws18/swo/ex01/asgmt/src/poly/main.c
        ws18/swo/ex01/ue/hello/hello.c
        ws18/swo/ex01/ue/printf/printf_test.c
        ws18/swo/ex01/ue/sum/sum.c
        ws18/swo/ex02/asgmt/src/gross/main.c
        ws18/swo/ex02/asgmt/src/hamming/main.c
        ws18/swo/ex02/asgmt/src/sort/main.c
        ws18/swo/ex02/ue/arrays.c
        ws18/swo/ex02/ue/main.c
        ws18/swo/ex02/ue/max_rec.c)
