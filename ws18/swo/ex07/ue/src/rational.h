//
// Created by khp on 19.11.18.
//

#ifndef PROJECT_RATIONAL_H
#define PROJECT_RATIONAL_H

#include <iostream>

namespace swo3 {
    class rational {
        friend std::ostream &operator<<(std::ostream&, const rational&);
    public:
        rational();

        rational(int);

        rational(int, int);

        ~rational();

        rational &operator+=(const rational&);


        void print(std::ostream & = std::cout) const;

    private:
        void reduce();

        int _num{0};    //numerator
        int _den{1};    //denominator
    };
    rational operator+(const rational&, const rational&);
}


#endif //PROJECT_RATIONAL_H
