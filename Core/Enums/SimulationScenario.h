#ifndef SIMULATIONSCENARIO_H
#define SIMULATIONSCENARIO_H

#include <cstdint>

enum class SimulationScenario : std::uint8_t
{
    NORMAL = 0,
    WARNING,
    CRITICAL
};

#endif // SIMULATIONSCENARIO_H
