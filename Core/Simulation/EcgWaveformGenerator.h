#ifndef ECGWAVEFORMGENERATOR_H
#define ECGWAVEFORMGENERATOR_H

#include <QtCore/qglobal.h>

struct SignalCenter
{
    static constexpr double P_CENTER = 0.78;
    static constexpr double Q_CENTER = 0.96;
    static constexpr double R_CENTER = 0.00;
    static constexpr double S_CENTER = 0.04;
    static constexpr double T_CENTER = 0.27;
};

struct SignalWidth
{
    static constexpr double P_WIDTH = 0.045;
    static constexpr double Q_WIDTH = 0.012;
    static constexpr double R_WIDTH = 0.010;
    static constexpr double S_WIDTH = 0.014;
    static constexpr double T_WIDTH = 0.090;
};

struct SignalAmplitude
{
    static constexpr double P_AMPLITUDE = 0.12;
    static constexpr double Q_AMPLITUDE = -0.15;
    static constexpr double R_AMPLITUDE = 1.00;
    static constexpr double S_AMPLITUDE = -0.25;
    static constexpr double T_AMPLITUDE = 0.30;
};

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
