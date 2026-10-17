#ifndef SIMULATIONSCENARIOFACTORY_H
#define SIMULATIONSCENARIOFACTORY_H

#include "Core/Enums/SimulationScenario.h"
#include "Core/Simulation/SimulationConfig.h"

class SimulationScenarioFactory final
{
public:
    static SimulationConfig Create(SimulationScenario scenario)
    {
        SimulationConfig config;

        switch (scenario)
        {
        case SimulationScenario::WARNING:
            config.heartRate = { 88, 110, 3 };
            config.oxygenSaturation = { 92, 97, 1 };
            config.respiratoryRate = { 19, 25, 2 };
            config.temperature = { 370, 380, 1 };
            break;

        case SimulationScenario::CRITICAL:
            config.heartRate = { 110, 135, 4 };
            config.oxygenSaturation = { 86, 93, 2 };
            config.respiratoryRate = { 25, 34, 2 };
            config.temperature = { 380, 395, 2 };
            break;

        case SimulationScenario::NORMAL:
        default:
            break;
        }

        return config;
    }
};

#endif // SIMULATIONSCENARIOFACTORY_H
