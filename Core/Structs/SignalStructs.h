#ifndef SIGNALSTRUCTS_H
#define SIGNALSTRUCTS_H

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

#endif // SIGNALSTRUCTS_H