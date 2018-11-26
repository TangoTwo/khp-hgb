#include <iostream>
#include "simpleString.h"

static void testConstruction() {
    swo::simpleString s1{"HELLO"};
    swo::simpleString empty;

    swo::simpleString s2{s1};
    swo::simpleString s3(s1);
    swo::simpleString s4 = s1;
}

static void doSomething(swo::simpleString s) {
    std::cout << "doSomething" << std::endl;
}

static void testCallByValue() {
    swo::simpleString s1{"xxx"};
    doSomething(s1);
}

static void testOutputOperator() {
    swo::simpleString s1{"abc"};
    std::cout << "s1=" << s1 << std::endl;
}

static void testAppendOperator() {
    swo::simpleString s1{"xxx"};
    swo::simpleString s2{"yyy"};
    std::cout << "s1=" << s1 << std::endl;
    std::cout << "s2=" << s2 << std::endl;

    s1 += s2;
    std::cout << "s1=" << s1 << std::endl;

    s1 += "zzz"; // s1.operator+=(simpleString("zzz"));
    std::cout << "s1=" << s1 << std::endl;
}

static void testAssignmentOperator() {
    swo::simpleString s1{"xxx"};
    swo::simpleString s2{"yyy"};
    swo::simpleString s3{"zzz"};

    std::cout << "s1 = " << s1 << std::endl;
    std::cout << "s2 = " << s2 << std::endl;
    std::cout << "s3 = " << s3 << std::endl;

    s3 = s2 = s1;

    std::cout << "s1 = " << s1 << std::endl;
    std::cout << "s2 = " << s2 << std::endl;
    std::cout << "s3 = " << s3 << std::endl;
}

static void testIndexOperator() {
    swo::simpleString s{"abcd"};

    for (int i = 0; i < s.size(); ++i) {
        std::cout << "s[" << i << "] = " << s[i] << std::endl;
    }
    s[1] = 'x';
    std::cout << "s = " << s << std::endl;
}

int main() {
    std::cout << "simple_string tests" << std::endl;
    std::cout << "TEST 1:" << std::endl;
    testConstruction();
    std::cout << "TEST 2:" << std::endl;
    testCallByValue();
    std::cout << "TEST 3:" << std::endl;
    testOutputOperator();
    std::cout << "TEST 4:" << std::endl;
    testAppendOperator();
    std::cout << "TEST 5:" << std::endl;
    testAssignmentOperator();
    std::cout << "TEST 5:" << std::endl;
    testIndexOperator();

    return 0;
}