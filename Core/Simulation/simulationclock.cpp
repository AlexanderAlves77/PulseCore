#include "SimulationClock.h"
#include <Qt>

/* ======================================================================================== */

SimulationClock::SimulationClock(QObject * parent)
    : QObject(parent)
{
    tickTimer.setTimerType(Qt::PreciseTimer);
    tickTimer.setInterval(TICK_INTERVAL_MS);

    connect(
        &tickTimer,
        &QTimer::timeout,
        this,
        &SimulationClock::Update
        );
}

/* ======================================================================================== */

void SimulationClock::Start()
{
    if (running)
    {
        return;
    }

    running = true;

    elapsedTimer.start();
    tickTimer.start();
}

/* ======================================================================================== */

void SimulationClock::Pause()
{
    if (!running)
    {
        return;
    }

    accumulatedSeconds += static_cast<double>(elapsedTimer.elapsed()) / 1000.0;
    previousSeconds = accumulatedSeconds;
    tickTimer.stop();
    running = false;
}

/* ======================================================================================== */

void SimulationClock::Reset()
{
    tickTimer.stop();
    elapsedTimer.invalidate();

    running = false;
    accumulatedSeconds = 0.0;
    previousSeconds = 0.0;
    beatPhaseSeconds = 0.0;

    beatIntervalSeconds = 60.0 / static_cast<double>(DEFAULT_HEART_RATE);
}

/* ======================================================================================== */

void SimulationClock::SetHeartRate(int heartRate)
{
    if (heartRate <= 0)
    {
        return;
    }

    beatIntervalSeconds = 60.0 / static_cast<double>(heartRate);
}

/* ======================================================================================== */

bool SimulationClock::IsRunning() const noexcept
{
    return running;
}

/* ======================================================================================== */

double SimulationClock::GetElapsedSeconds() const noexcept
{
    if (!running)
    {
        return accumulatedSeconds;
    }

    return accumulatedSeconds + static_cast<double>(elapsedTimer.elapsed()) / 1000.0;
}

/* ======================================================================================== */

void SimulationClock::Update()
{
    if (!running)
    {
        return;
    }

    const double currentSeconds = GetElapsedSeconds();
    const double deltaSeconds = currentSeconds - previousSeconds;

    if (deltaSeconds < 0.0)
    {
        return;
    }

    previousSeconds = currentSeconds;
    beatPhaseSeconds += deltaSeconds;

    while (beatPhaseSeconds >= beatIntervalSeconds)
    {
        beatPhaseSeconds -= beatIntervalSeconds;

        const double beatTimeSeconds = currentSeconds - beatPhaseSeconds;

        emit BeatOccurred(beatTimeSeconds);
    }

    emit Tick(currentSeconds);
}