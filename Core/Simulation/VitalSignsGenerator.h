#ifndef VITALSIGNSGENERATOR_H
#define VITALSIGNSGENERATOR_H

#include "Core/Models/VitalSigns.h"
#include "Core/Simulation/SimulationConfig.h"


class VitalSignsGenerator final
{
private:
    int GenerateVariation(int minimum, int maximum) const;
    int GenerateNextValue(int currentValue, int minimum, int maximum, int maximumVariation) const;

public:
    VitalSignsGenerator() = default;

    VitalSigns GenerateNext(const VitalSigns & currentVitalSigns,
        const SimulationConfig& config) const;
};

#endif // VITALSIGNSGENERATOR_H
