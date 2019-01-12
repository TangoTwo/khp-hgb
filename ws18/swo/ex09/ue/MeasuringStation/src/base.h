//       $Id: base.h 1917 2018-11-29 09:16:40Z p20068 $
//      $URL: https://svn01.fh-hagenberg.at/se/sw/swo3/trunk/Vorbereitung/MeasuringStation-template/src/base.h $
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

#include <algorithm>
#include <cassert>
#include <chrono>
#include <ctime>
#include <iostream>
#include <iterator>
#include <memory>
#include <random>
#include <type_traits>

using namespace std::chrono_literals;

class actor;
class filter;
class information;
class object;
class sensor;
class station;

namespace util {

void sleep_for_a_while(std::chrono::milliseconds = 250ms);

template<typename cont_t> bool contains(cont_t const & cont,
		object const & obj) {
	return std::find(std::begin(cont), std::end(cont), &obj) != std::end(cont);
}

template<typename cont_t> bool erase_if_contained(cont_t & cont,
		object const & obj) {
  if (auto const f {std::find (std::begin (cont), std::end (cont), &obj)}; f != std::end (cont)) {
			cont.erase (f); return true;
	}

	return false;
}

template<typename T> T get_random_uniform(T const l, T const u) noexcept {
  static_assert (
     std::is_integral_v <T> || std::is_floating_point_v <T>,
     "get_random_uniform<T>: T must be an integral or floating-point type"
  );

  static std::mt19937_64 generator {
     static_cast <unsigned> (std::time (nullptr))   // better use seed sequences
  };

  if constexpr (std::is_integral_v <T>) {
     return std::uniform_int_distribution  <T> {l, u} (generator);
  } else {
     return std::uniform_real_distribution <T> {l, u} (generator);
  }
}

template<typename T> T & deref(T * const p) {
	assert(p);
	return *p;
}

template<typename T> T & deref(std::unique_ptr<T> const & p) {
	assert(p);
	return *p;
}

}   // namespace util
