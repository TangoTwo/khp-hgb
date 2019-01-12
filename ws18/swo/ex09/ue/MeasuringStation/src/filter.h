//       $Id: filter.h 1917 2018-11-29 09:16:40Z p20068 $
//      $URL: https://svn01.fh-hagenberg.at/se/sw/swo3/trunk/Vorbereitung/MeasuringStation-template/src/filter.h $
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

#pragma once

#include "./actor.h"
#include "./sensor.h"

class filter {
protected:
	explicit filter(const std::string &name);                   // abstract class
	explicit filter(const std::string &name, station &station); // abstract class
};

namespace util {

namespace util {

inline bool the_same_filter_object (sensor const & sensor, actor const & actor) {
//   auto const p_sensor {dynamic_cast <const filter *> (&sensor)};
//   auto const p_actor  {dynamic_cast <const filter *> (&actor)};
//
//   return p_sensor && (p_sensor == p_actor);
  return false;
}

}

}   // namespace util
