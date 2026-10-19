#ifndef ECGWAVEFORMGENERATOR_H
#define ECGWAVEFORMGENERATOR_H

#include <QtCore/qglobal.h>

class EcgWaveformGenerator final
{
private:
    double CalculateGaussian(
        double phase,
        double center,
        double width,
        double amplitude
        ) const;

public:
    EcgWaveformGenerator() = default;

    double GenerateSample(double elapsedSeconds, int heartRate) const;
};


#endif // ECGWAVEFORMGENERATOR_H
