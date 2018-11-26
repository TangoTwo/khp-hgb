//
// Created by khp on 26.11.18.
//

#ifndef SIMPLESTRING_SIMPLESTRING_H
#define SIMPLESTRING_SIMPLESTRING_H


#include <cstddef>

namespace swo {
    class simpleString {
        friend std::ostream &operator<<(std::ostream&, const simpleString&);
    public:
        using value_type = char;
        using pointer = value_type *;
        using const_pointer = const value_type *;

        simpleString();
        simpleString(const_pointer);
        simpleString(const simpleString&);
        ~simpleString();

        simpleString &operator+=(const simpleString&);
        simpleString &operator=(const simpleString &);
        value_type operator[](std::size_t) const;
        value_type &operator[](std::size_t);

        auto isEmpty() const { return _mData == nullptr;};
        auto size() const { return _mSize;};
    private:
        void copyFrom(const simpleString&);
        char*       _mData{nullptr};
        std::size_t _mSize{0};
    };
    std::ostream &operator<<(std::ostream&, const simpleString&);
}
#endif //SIMPLESTRING_SIMPLESTRING_H
