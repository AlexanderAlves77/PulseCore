#include "Core/Simulation/VitalSignsGenerator.h"
#include <QRandomGenerator>
#include <algorithm>
#include <cmath>

int VitalSignsGenerator::GenerateVariation(int minimum, int maximum) const
{
    return QRandomGenerator::global()->bounded(minimum, maximum + 1);
}

int VitalSignsGenerator::GenerateNextValue(int currentValue, int minimum,
    int maximum, int maximumVariation) const
{
    const int variation = GenerateVariation(-maximumVariation, maximumVariation);

    const int nextValue = currentValue + variation;

    return std::clamp(nextValue, variation, maximum);
}

VitalSigns VitalSignsGenerator::GenerateNext(const VitalSigns & currentVitalSigns) const
{
    VitalSigns nextVitalSigns = currentVitalSigns;

    nextVitalSigns.heartRate = GenerateNextValue(
        currentVitalSigns.heartRate, 72, 88, 2
    );

    nextVitalSigns.oxygenSaturation = GenerateNextValue(
        currentVitalSigns.oxygenSaturation, 96, 100, 1
    );

    nextVitalSigns.respiratoryRate = GenerateNextValue(
        currentVitalSigns.respiratoryRate, 14, 20, 1
    );

    const int currentTemperatureTenths = static_cast<int>(
        std::lround(currentVitalSigns.temperature * 10.0)
    );

    const int nexttemperatureTenths = GenerateNextValue(
        currentTemperatureTenths, 365, 372, 1
    );

    nextVitalSigns.temperature = static_cast<double>(nexttemperatureTenths) / 10.0;

    return nextVitalSigns;
}