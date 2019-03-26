//
// Created by khp on 25.03.19.
//

#include <iostream>
#include <random>
#include "EventQueue.h"
#include "Machine.h"
#include "EventQueueSupervisor.h"


int main() {
  EventQueue<Machine<int,int>> queue;
  EventQueueSupervisor<Machine<int, int>> supervisor(queue);
  std::queue<int> beginCont;
  std::queue<int> middleCont;
  std::queue<int> endCont;

  double machineTimeMean = 100;
  double machineTimeDev = 20;
  supervisor.addFunction([](EventQueue<Machine<int, int>>& queue1){ return queue1.getTime() > 2000;});
  std::random_device rd;
  std::mt19937 gen{rd()};
  std::normal_distribution<> d{machineTimeMean,machineTimeDev};

  Machine<int, int> machine1(100, [](const int& i){ return i * 10;}, &queue, &beginCont, &middleCont, std::round(d(gen)));
  Machine<int, int> machine3(110, [](const int& i){ return i * 20;}, &queue, &beginCont, &middleCont, std::round(d(gen)));
  Machine<int, int> machine4(120, [](const int& i){ return i * 30;}, &queue, &middleCont, &endCont, std::round(d(gen)));
  Machine<int, int> machine2(200, [](const int& i){ return i * 40;}, &queue, &middleCont, &endCont, std::round(d(gen)));
  queue.add(machine1);
  queue.add(machine2);
  queue.add(machine3);
  queue.add(machine4);
  beginCont.push(2);
  beginCont.push(2);
  beginCont.push(2);

  int i = 1;
  //queue.run();
  while(!middleCont.empty() || !beginCont.empty()){
    std::cout << i << ". Round:" << std::endl;
    std::cout << "Begin Container:" << beginCont.size() << std::endl;
    std::cout << "Middle Container:" << middleCont.size() << std::endl;
    std::cout << "End Container:" << endCont.size() << std::endl;
    std::cout << std::endl << std::endl;
    queue.step();
    i++;
  }
}