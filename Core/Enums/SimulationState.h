#pragma once

#include <cstdint>

enum class SimulationState : std::uint8_t
{
    STOPPED = 0,
    RUNNING,
    PAUSED
};
