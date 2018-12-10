//
// Created by khp on 10.12.18.
//

#include <iostream>
#include <string>
#include "vector.h"

using std::cout;
using std::endl;

int main() {
    swo::vector<int> vi1(5);
    swo::vector<int> vi2{5};
    swo::vector<int> vi3{1,3,5};
    swo::vector<std::string> v2(5);

    cout << "vi1 = " << vi1 << endl;
    cout << "vi2 = " << vi2 << endl;
    cout << "vi3 = " << vi3 << endl;

    v2.push_back("Hagenberg");
    v2.push_back("Vienna");
    v2.push_back("New York");

    swo::vector<std::string> v3{v2};
    cout << "v2 = " << v2 << endl;
    cout << "v3 = " << v3 << endl;
}
