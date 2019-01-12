//       $Id: station.cpp 1917 2018-11-29 09:16:40Z p20068 $
//      $URL: https://svn01.fh-hagenberg.at/se/sw/swo3/trunk/Vorbereitung/MeasuringStation-template/src/station.cpp $
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

#include "base.h"
#include "station.h"


#include <iostream>

station::station(const std::string &name) : m_name{name}{
	std::cout << "Station '" << m_name << "': " << "Got constructed.\n";
}

station::~station() {
	std::cout << "Station '" << m_name << "': " << "Got destructed.\n";
	for (sensor *s : m_sensors) {
		s->detach(*this);
	}
	m_sensors.clear();

}

void station::attach(sensor &sensor) {
	if(!util::contains(m_sensors, sensor)) {
		m_sensors.push_back(&sensor);
		std::cout << "Station '" << m_name << "': " << "Attached Sensor :'" << sensor.get_name() << "'." << std::endl;
	}
}

void station::detach(sensor &sensor) {
	if(util::erase_if_contained(m_sensors, sensor))
		std::cout << "Station '" << m_name << "': " << "Detached Sensor :'" << sensor.get_name() << "'." << std::endl;
}

void station::run(size_t tick) const {
	while (tick-- > 0) {
		std::cout << "Station '" << m_name << "': " << "Ticking...'" << std::endl;
		tick_sensors();
		util::sleep_for_a_while();
	}
}

void station::tick_sensors() const {
	for(sensor* s : m_sensors) {
		s->tick();
	}
}
