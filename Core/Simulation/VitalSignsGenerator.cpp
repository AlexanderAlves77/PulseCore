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

    return std::clamp(nextValue, minimum, maximum);
}

VitalSigns VitalSignsGenerator::GenerateNext(const VitalSigns & currentVitalSigns,
    const SimulationConfig& config) const
{
    VitalSigns nextVitalSigns = currentVitalSigns;

    nextVitalSigns.heartRate = GenerateNextValue(
        currentVitalSigns.heartRate,
        config.heartRate.minimum,
        config.heartRate.maximum,
        config.heartRate.maximumVariation
    );

    nextVitalSigns.oxygenSaturation = GenerateNextValue(
        currentVitalSigns.oxygenSaturation,
        config.oxygenSaturation.minimum,
        config.oxygenSaturation.maximum,
        config.oxygenSaturation.maximumVariation
    );

    nextVitalSigns.respiratoryRate = GenerateNextValue(
        currentVitalSigns.respiratoryRate,
        config.respiratoryRate.minimum,
        config.respiratoryRate.maximum,
        config.respiratoryRate.maximumVariation
    );

    const int currentTemperatureTenths = static_cast<int>(
        std::lround(currentVitalSigns.temperature * 10.0)
    );

    const int nexttemperatureTenths = GenerateNextValue(
        currentTemperatureTenths,
        config.temperature.minimum,
        config.temperature.maximum,
        config.temperature.maximumVariation
    );

    nextVitalSigns.temperature = static_cast<double>(nexttemperatureTenths) / 10.0;

    return nextVitalSigns;
}