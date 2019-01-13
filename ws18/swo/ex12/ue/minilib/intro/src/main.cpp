//
// Created by khp on 07.01.19.
//

#include <ml5/ml5.h>
#include <memory>
#include <iostream>

using string_vector = ml5::vector<ml5::string >;
using namespace std;

static void test_container() {
    ml5::vector<ml5::string> cont;
    cont.add("Hagenberg"s);
    cont.add("Linz"s);
    cont.add("Wien"s);
    cont.add("Salzburg"s);
    cout << "cont = " << cont << endl;

    cont.remove("Salzburg"s);
    cout << "cont = " << cont << endl;

    std::unique_ptr<ml5::iterator<ml5::string>> it = cont.make_iterator();
}
int main() {
    ml5::string helloMag("Hello ML5");

    std::cout << helloMag << std::endl;

    cout << "==== test_countainer ====" << endl;
    test_container();
}