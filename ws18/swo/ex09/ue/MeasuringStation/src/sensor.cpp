//       $Id: sensor.cpp 1917 2018-11-29 09:16:40Z p20068 $
//      $URL: https://svn01.fh-hagenberg.at/se/sw/swo3/trunk/Vorbereitung/MeasuringStation-template/src/sensor.cpp $
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

#include "./filter.h"
#include "./station.h"
#include "./status_info.h"
#include "sensor.h"


#include <cassert>

sensor::sensor(const std::string &name) : m_name{name} {
    std::cout << "Sensor '" << m_name << "': " << " Got constructed.\n";
}

sensor::sensor(const std::string &name, station &station) : m_name{name}, m_p_station{&station} {
    station.attach(*this);
    std::cout << "Sensor '" << m_name << "': " << " Got constructed.\n";
}

sensor::~sensor() {
    if (m_p_station) detach(*m_p_station);
    detach_all_actors();
    std::cout << "Sensor '" << m_name << "': " << " Got destructed.\n";
}

void sensor::attach(station &station) {
    if (!m_p_station) {
        m_p_station = &station;
        std::cout << "Sensor '" << m_name << "': " << "Attached from station :'" << station.get_name() << "'."
                  << std::endl;
    }
}

void sensor::detach(station &station) {
    if (m_p_station == &station) {
        m_p_station = nullptr;
        std::cout << "Sensor '" << m_name << "': " << "Detached from station :'" << station.get_name() << "'."
                  << std::endl;
    }
}

void sensor::tick() {
    m_ticks++;
    //std::cout << "Sensor '" << m_name << "': " << m_ticks << " ticks." << std::endl;
    on_tick();
}

void sensor::attach(actor &actor) {
    if (!util::contains(m_actors, actor)) {
        m_actors.push_back(&actor);
        actor.got_attached_to(*this);
        std::cout << "Sensor '" << m_name << "': " << "Actor'" << actor.get_name() << "' attached."
                  << std::endl;
    }
}

void sensor::detach(actor &actor) {
    if (util::erase_if_contained(m_actors, actor)) {
        actor.got_detached_from(*this);
        std::cout << "Sensor '" << m_name << "': " << "Actor'" << actor.get_name() << "' detached."
                  << std::endl;
    }
}

void sensor::detach_all_actors() {
    for (actor *a : m_actors)
        a->got_detached_from(*this);
    std::cout << "Sensor '" << m_name << "': " << "All actors detached."
              << std::endl;
    m_actors.clear();
}

void sensor::notify_all_actors(const double &info) {
    for(actor* a : m_actors) {
        a->notify(info);
    }
}
