//
// Created by khp on 26.03.19.
//

#ifndef SWO3_MACHINE_H
#define SWO3_MACHINE_H

#include <queue>
#include "Event.h"

#define WAIT_PERIOD_IF_EMPTY 20

template <typename input, typename output>
struct Machine : Event{
  Machine(unsigned int execTime,
      std::function<const output(const input&)> execFct,
      EventQueue<Machine<input, output>>* parentQueue,
      std::queue<input>* inputCont,
      std::queue<output>* outputCont,
      unsigned int machineTime
      ) : _execFct{execFct}, _machineTime{machineTime}
  {
    _execTime = execTime;
    _inputCont = inputCont;
    _outputCont = outputCont;
    _parentQueue = parentQueue;
  };
  void execute() override {
    if(!_inputCont->empty()){
      _outputCont->push(_execFct(_inputCont->front()));
      _inputCont->pop();
      this->_execTime = _execTime + _machineTime;
      _parentQueue->add(*this);
    } else {
      this->_execTime = _execTime + WAIT_PERIOD_IF_EMPTY;
      _parentQueue->add(*this);
    }
  }
 private:
  std::function<const output(const input&)> _execFct;
  std::queue<input>* _inputCont;
  std::queue<output>* _outputCont;
  EventQueue<Machine<input, output>>* _parentQueue;
  unsigned int _machineTime;
};

#endif //SWO3_MACHINE_H
