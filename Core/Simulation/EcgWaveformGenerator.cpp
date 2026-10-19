
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

    return GenerateSampleFromPhase(phase);
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
    else if (distance < -0.5)
    {
        distance += 1.0;
    }

    const double normalizedDistance = distance / width;

    return amplitude * std::exp(-0.5 * normalizedDistance * normalizedDistance);
}

/* ======================================================================================== */

double EcgWaveformGenerator::GenerateSampleFromPhase(double phase) const
{
    if (!std::isfinite(phase) || phase < 0.0 || phase > 1.0)
    {
        return 0.0;
    }

    const double pWave = CalculateGaussian(
        phase,
        SignalCenter::P_CENTER,
        SignalWidth::P_WIDTH,
        SignalAmplitude::P_AMPLITUDE
    );

    const double qWave = CalculateGaussian(
        phase,
        SignalCenter::Q_CENTER,
        SignalWidth::Q_WIDTH,
        SignalAmplitude::Q_AMPLITUDE
    );

    const double rWave = CalculateGaussian(
        phase,
        SignalCenter::R_CENTER,
        SignalWidth::R_WIDTH,
        SignalAmplitude::R_AMPLITUDE
    );

    const double sWave = CalculateGaussian(
        phase,
        SignalCenter::S_CENTER,
        SignalWidth::S_WIDTH,
        SignalAmplitude::S_AMPLITUDE
    );

    const double tWave = CalculateGaussian(
        phase,
        SignalCenter::T_CENTER,
        SignalWidth::T_WIDTH,
        SignalAmplitude::T_AMPLITUDE
    );

    const double sample = pWave + qWave + rWave + sWave + tWave;

    return std::clamp(sample, -1.0, 1.0);
}
