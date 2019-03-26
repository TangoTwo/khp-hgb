//
// Created by khp on 25.03.19.
//

#ifndef SWO3_EVENTQUEUE_H
#define SWO3_EVENTQUEUE_H

#include <queue>
#include "Event.h"
#include "EventQueueSupervisor.h"

template <typename EventTemplate = Event>
struct EventQueue {
  using time = unsigned int;
  void add(EventTemplate event) {
    _queue.push(std::move(event));
  }

  void run() {
    _stopped = false;
    while(!_queue.empty() && !_stopped){
      this->step();
    }
  }

  void run(const EventQueueSupervisor<EventTemplate>& supervisor) {
    _stopped = false;
    while(!_queue.empty() && !_stopped){
      this->step();
      if(supervisor.checkIfStop())
        this->stop();
    }
  }

  void stop(){
    _stopped = true;
  };
  void step(){
    if(_queue.empty()){
      std::cerr << "Queue is empty!" << std::endl;
      return;
    }
    const_cast<EventTemplate&>(_queue.top()).execute();
    _currentTime = _queue.top().getTime();
    std::cout << "Current Time: " << _currentTime << std::endl;
    _queue.pop();
  };

  time getTime() const { return _currentTime;};

 private:
  bool _stopped{false};
  time _currentTime{0};
  std::priority_queue<EventTemplate, std::vector<EventTemplate>, std::greater<>> _queue;
};
#endif //SWO3_EVENTQUEUE_H
