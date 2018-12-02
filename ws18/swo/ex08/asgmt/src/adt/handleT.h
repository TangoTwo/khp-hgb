//
// Created by khp on 01.12.18.
//

#ifndef SWO_HANDLET_H
#define SWO_HANDLET_H


class handle_t {
public:
    handle_t(unsigned long int id);
    unsigned long int getID() const;

private:
    unsigned long int id{0};
};


#endif //SWO_HANDLET_H
