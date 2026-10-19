
#include "EcgWaveformGenerator.h"
#include <algorithm>
#include <cmath>


/* ======================================================================================== */

double EcgWaveformGenerator::GenerateSample(double elapsedSeconds, int heartRate) const
{
    if (!std::isfinite(elapsedSeconds) || elapsedSeconds < 0.0 || heartRate <= 0)
    {
        return 0.0;
    }

    const double beatDuration = SECONDS_PER_MINUTE / heartRate;

    const double beatPosition = std::fmod(elapsedSeconds, beatDuration);

    const double phase = beatPosition / beatDuration;

    const double pWave = CalculateGaussian(
        phase,
        signalCenter.P_CENTER,
        signalWidth.P_WIDTH,
        signalAmplitude.P_AMPLITUDE
    );

    const double qWave = CalculateGaussian(
        phase,
        signalCenter.Q_CENTER,
        signalWidth.Q_WIDTH,
        signalAmplitude.Q_AMPLITUDE
    );

    const double rWave = CalculateGaussian(
        phase,
        signalCenter.R_CENTER,
        signalWidth.R_WIDTH,
        signalAmplitude.R_AMPLITUDE
    );

    const double sWave = CalculateGaussian(
        phase,
        signalCenter.S_CENTER,
        signalWidth.S_WIDTH,
        signalAmplitude.S_AMPLITUDE
    );

    const double tWave = CalculateGaussian(
        phase,
        signalCenter.T_CENTER,
        signalWidth.T_WIDTH,
        signalAmplitude.T_AMPLITUDE
    );

    const double sample = pWave + qWave + rWave + sWave + tWave;

    return std::clamp(sample, -1.0, 1.0);
}

/* ======================================================================================== */

double EcgWaveformGenerator::CalculateGaussian(
    double phase,
    double center,
    double width,
    double amplitude
    ) const
{
    double distance = phase - center;

    if (distance > 0.5)
    {
        distance -= 1.0;
    }
    else if (distance > -0.5)
    {
        distance += 1.0;
    }

    const double normalizedDistance = distance / width;

    return amplitude * std::exp(-0.5 * normalizedDistance * normalizedDistance);
}
