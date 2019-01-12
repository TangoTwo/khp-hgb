//       $Id: actor.h 1917 2018-11-29 09:16:40Z p20068 $
//      $URL: https://svn01.fh-hagenberg.at/se/sw/swo3/trunk/Vorbereitung/MeasuringStation-template/src/actor.h $
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

#include "./information.h"

#include <string>
#include <vector>

class actor : public object{

public:
	~actor();

	void got_attached_to(sensor &sensor);
	void got_detached_from(sensor &sensor);

	const auto &get_name() const {
		return m_name;
	}

	void notify(const double info);

protected:
	explicit actor(const std::string &name);   // abstract class
	virtual void on_notify(double info) = 0;

private:
    void detach_from_all_sensors();
	std::string m_name {};
	std::vector<sensor*> m_sensors{};
	bool m_detaching{false};
};
