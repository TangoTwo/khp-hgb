//
// Created by khp on 14.01.19.
//

#include <iostream>
#include "ml5/ml5.h"
#include "list.h"

using std::cout;
using std::endl;

using namespace std::string_literals;

static void test_list() {
    list<ml5::string> cities;

    cities.add("Hagenberg"s);
    cities.add("Salzburg"s);
    cities.add("Linz"s);

    cout << std::boolalpha;
    cout << cities.size();

    cities.remove("Linz"s);
    cout << cities.size();


}
int main() {
    ml5::string msg{"Tests for MiniLib list"};
    cout << msg << endl;

    test_list();

}