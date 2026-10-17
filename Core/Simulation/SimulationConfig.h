#ifndef SIMULATIONCONFIG_H
#define SIMULATIONCONFIG_H


struct VitalSignRange
{
    int minimum;
    int maximum;
    int maximumVariation;
};

struct SimulationConfig
{
    int updateIntervalMs = 1000;

    VitalSignRange heartRate{
        72, 88, 2
    };

    VitalSignRange oxygenSaturation{
        96, 100, 1
    };

    VitalSignRange respiratoryRate{
        14, 20, 1
    };

    // Temperature values are expressed in tenths of a degree.
    VitalSignRange temperature{
        365, 372, 1
    };
};


#endif // SIMULATIONCONFIG_H
