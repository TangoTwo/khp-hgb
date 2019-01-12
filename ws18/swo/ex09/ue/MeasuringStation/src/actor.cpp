//       $Id: actor.cpp 1917 2018-11-29 09:16:40Z p20068 $
//      $URL: https://svn01.fh-hagenberg.at/se/sw/swo3/trunk/Vorbereitung/MeasuringStation-template/src/actor.cpp $
// $Revision: 1917 $
//     $Date: 2018-11-29 10:16:40 +0100 (Do., 29 Nov 2018) $
//   $Author: p20068 $
//
//   Creator: Peter Kulczycki
//  Creation: November 1, 2018
// Copyright: (c) 2018 Peter Kulczycki (peter.kulczycki<AT>fh-hagenberg.at)
//
//   License: This document contains proprietary information belonging to
//            University of Applied Sciences Upper Austria, Campus Hagenberg.
//            It is distributed under the Boost Software License, Version 1.0
//            (see http://www.boost.org/LICENSE_1_0.txt).

#include "./actor.h"
#include "./sensor.h"
#include "actor.h"


actor::actor(const std::string &name) {
    std::cout << "Actor '" << m_name << "': " << "Got constructed.\n";
}

actor::~actor() {
    std::cout << "Actor '" << m_name << "': " << "Got destructed.\n";
}

void actor::got_attached_to(sensor &sensor) {
    if(!util::contains(m_sensors, sensor)) {
        m_sensors.push_back(&sensor);
        std::cout << "Actor '" << m_name << "': " << "Got attached to sensor '" << sensor.get_name() << "'." << std::endl;
    }
}

void actor::got_detached_from(sensor &sensor) {
    if(!m_detaching && util::erase_if_contained(m_sensors, sensor)) {
        std::cout << "Actor '" << m_name << "': " << "Got detached from sensor '" << sensor.get_name() << "'." << std::endl;
    }
}

void actor::detach_from_all_sensors() {
    m_detaching = true;
    for(sensor* s : m_sensors) {
        s->detach(*this);
    }
    m_sensors.clear();
    m_detaching = false;
}

void actor::notify(const double info) {
    on_notify(info);
}
