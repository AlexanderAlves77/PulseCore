#ifndef ECGWAVEFORMGENERATOR_H
#define ECGWAVEFORMGENERATOR_H

#include <QtCore/qglobal.h>

class EcgWaveformGenerator final
{
private:
    static constexpr double SECONDS_PER_MINUTE = 60.0;

    double CalculateGaussian(
        double phase,
        double center,
        double width,
        double amplitude
    ) const;

public:
    EcgWaveformGenerator() = default;

    double GenerateSample(double elapsedSeconds, int heartRate) const;
    double GenerateSampleFromPhase(double phase) const;
};


#endif // ECGWAVEFORMGENERATOR_H
