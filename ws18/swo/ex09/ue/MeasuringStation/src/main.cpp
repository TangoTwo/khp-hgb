//       $Id: main.cpp 1917 2018-11-29 09:16:40Z p20068 $
//      $URL: https://svn01.fh-hagenberg.at/se/sw/swo3/trunk/Vorbereitung/MeasuringStation-template/src/main.cpp $
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

#include "./alarm_filter.h"
#include "./broadcast_actor.h"
#include "./pressure_sensor.h"
#include "./print_actor.h"
#include "./station.h"
#include "./temperature_sensor.h"

int main() {
	std::cout
			<< "---------- creating stations --------------------------------\n\n";
	station* m_p_station = new station("Hagenberg");
	std::cout
			<< "\n---------- creating sensors, actors, and filters ------------\n\n";

	temperature_sensor s1{"Temperature", *m_p_station};
	pressure_sensor s2{"Pressure", *m_p_station};

	print_actor a1{"Console_printer"};
	std::cout
			<< "\n---------- wiring sensors, actors, and filters --------------\n\n";
	s1.attach(a1);
	s2.attach(a1);

	std::cout
			<< "\n---------- driving the application --------------------------\n";
	m_p_station->run();
	std::cout
			<< "\n---------- deleting stations --------------------------------\n\n";
	delete m_p_station;
	std::cout
			<< "\n---------- terminating the application ----------------------\n\n";
}
