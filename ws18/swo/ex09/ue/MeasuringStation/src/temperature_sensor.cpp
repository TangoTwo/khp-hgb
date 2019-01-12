//       $Id: temperature_sensor.cpp 1917 2018-11-29 09:16:40Z p20068 $
//      $URL: https://svn01.fh-hagenberg.at/se/sw/swo3/trunk/Vorbereitung/MeasuringStation-template/src/temperature_sensor.cpp $
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

#include "./alarm_info.h"
#include "./temperature_sensor.h"
#include "./value_info.h"
#include "temperature_sensor.h"


temperature_sensor::temperature_sensor(const std::string &name, station &station) : base{name, station} {

}

void temperature_sensor::on_tick() {
    if(get_ticks() %2 == 0)
        notify_all_actors(util::get_random_uniform(0.0, 20.0));
    std::cout << "temperature_sensor '" << get_name() << "' : on_tick()." << std::endl;
}
