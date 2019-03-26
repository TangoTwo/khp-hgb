//
// Created by khp on 26.03.19.
//

#ifndef SWO3_EVENTQUEUESUPERVISOR_H
#define SWO3_EVENTQUEUESUPERVISOR_H


template <typename Type = Event>
struct EventQueueSupervisor {
  EventQueueSupervisor(EventQueue<Type>& queue) : _queue{queue}{};
  bool checkIfStop() const {
    for (auto &item : _functions) {
      if(item(_queue)) return true;
    }
    return false;
  }
  void addFunction(std::function<bool(EventQueue<Type>& queue)> fct) {
    _functions.push_back(fct);
  }

 private:
  EventQueue<Type>& _queue;
  std::vector<std::function<bool(EventQueue<Type>&)>> _functions;
};
#endif //SWO3_EVENTQUEUESUPERVISOR_H
