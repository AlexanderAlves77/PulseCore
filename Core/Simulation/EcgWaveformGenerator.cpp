
#include "EcgWaveformGenerator.h"

#include <algorithm>
#include <cmath>

namespace
{
constexpr double SECONDS_PER_MINUTE = 60.0;

constexpr double P_CENTER = 0.18;
constexpr double Q_CENTER = 0.37;
constexpr double R_CENTER = 0.40;
constexpr double S_CENTER = 0.43;
constexpr double T_CENTER = 0.67;

constexpr double P_WIDTH = 0.045;
constexpr double Q_WIDTH = 0.012;
constexpr double R_WIDTH = 0.010;
constexpr double S_WIDTH = 0.014;
constexpr double T_WIDTH = 0.090;

constexpr double P_AMPLITUDE = 0.12;
constexpr double Q_AMPLITUDE = -0.15;
constexpr double R_AMPLITUDE = 1.00;
constexpr double S_AMPLITUDE = -0.25;
constexpr double T_AMPLITUDE = 0.30;
}

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

    const double pWave = CalculateGaussian(phase, P_CENTER, P_WIDTH, P_AMPLITUDE);

    const double qWave = CalculateGaussian(phase, Q_CENTER, Q_WIDTH, Q_AMPLITUDE);

    const double rWave = CalculateGaussian(phase, R_CENTER, R_WIDTH, R_AMPLITUDE);

    const double sWave = CalculateGaussian(phase, S_CENTER, S_WIDTH, S_AMPLITUDE);

    const double tWave = CalculateGaussian(phase, T_CENTER, T_WIDTH, T_AMPLITUDE);

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
    const double distance = (phase - center) / width;

    return amplitude * std::exp(-0.5 * distance * distance);
}
