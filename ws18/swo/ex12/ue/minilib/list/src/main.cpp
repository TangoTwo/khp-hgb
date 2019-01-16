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

static void test_iter() {
    list<ml5::string> cities;

    cities.add("Hagenberg"s);
    cities.add("Salzburg"s);
    cities.add("Linz"s);

    std::unique_ptr<ml5::iterator<ml5::string>> it = cities.make_iterator();
    while (it->not_at_end()) {
        cout << it->get_current() << endl;
        it->to_next();
    }
}
static void fill_container(ml5::container<ml5::integer> &cont) {
    for (int i = 0; i < 5; ++i) {
        cont.add(ml5::integer(i));
    }
}

template <typename T>
void print_container(ml5::container<ml5::container<T>> &cont){
    std::unique_ptr<ml5::iterator<T>> it = cont.make_iterator();
    while ( it->not_at_end()) {
        cout << it->get_current() << endl;
        it->to_next();
    }
}
static void test_polymorph() {
    list<ml5::integer> numberList;
    ml5::vector<ml5::integer> numberVector;

    fill_container(numberList);
    fill_container(numberVector);

    print_container(numberList);
    print_container(numberVector);
}

int main() {
    ml5::string msg{"Tests for MiniLib list"};
    cout << msg << endl;

    test_list();

}