//       $Id: sensor.h 1917 2018-11-29 09:16:40Z p20068 $
//      $URL: https://svn01.fh-hagenberg.at/se/sw/swo3/trunk/Vorbereitung/MeasuringStation-template/src/sensor.h $
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

#include "./object.h"

#include <string>
#include <vector>

class sensor : public object {

public:

    ~sensor();

    void attach(station &station);

    void detach(station &station);

    void attach(actor &actor);

    void detach(actor &actor);

    const auto &get_name() const {
        return m_name;
    }
    auto get_ticks () const {return m_ticks;}
    void tick();

protected:
    explicit sensor(const std::string &name);

    explicit sensor(const std::string &name, station &station);

    virtual void on_tick() = 0;

    void notify_all_actors(const double &info);

private:
    std::string m_name{};
    station *m_p_station{nullptr};
    int m_ticks{0};
    std::vector<actor *> m_actors{};

    void detach_all_actors();
};
