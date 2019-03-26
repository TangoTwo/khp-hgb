#include <utility>

//
// Created by khp on 25.03.19.
//

#ifndef SWO3_EVENT_H
#define SWO3_EVENT_H

#include <functional>

template <typename T>
struct EventQueue;

struct Event {
  virtual unsigned int getTime() const { return _execTime;};
  virtual void execute() = 0;
  bool operator< (const Event& rhs)const{ return this->_execTime < rhs._execTime;};
  bool operator> (const Event& rhs)const{ return rhs._execTime < this->_execTime; };
  bool operator<=(const Event& rhs)const{ return !(*this > rhs); };
  bool operator>=(const Event& rhs)const{ return !(*this < rhs); };
 protected:
  unsigned int _execTime;
  EventQueue<Event>* _parentQueue;
};

#endif //SWO3_EVENT_H
