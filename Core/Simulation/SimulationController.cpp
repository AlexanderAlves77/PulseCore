#include "Core/Simulation/SimulationController.h"

SimulationController::SimulationController(QObject * parent)
    : QObject(parent) {}

bool SimulationController::IsRunning() const noexcept
{
    return currentState == SimulationState::RUNNING;
}

QString SimulationController::GetStateName() const
{
    switch (currentState)
    {
    case SimulationState::RUNNING:
        return QStringLiteral("RUNNING");
    case SimulationState::PAUSED:
        return QStringLiteral("PAUSED");
    case SimulationState::STOPPED:
    default:
        return QStringLiteral("STOPPED");
    }
}

int SimulationController::GetHeartRate() const noexcept
{
    return vitalSigns.heartRate;
}

void SimulationController::Start()
{
    if (currentState == SimulationState::RUNNING)
    {
        return;
    }

    currentState = SimulationState::RUNNING;

    emit StateChanged();
}

void SimulationController::Pause()
{
    if (currentState != SimulationState::RUNNING)
    {
        return;
    }

    currentState = SimulationState::PAUSED;

    emit StateChanged();
}

void SimulationController::Reset()
{
    const bool stateChanged = currentState != SimulationState::STOPPED;
    currentState = SimulationState::STOPPED;

    vitalSigns = VitalSigns();

    if (stateChanged)
    {
        emit StateChanged();
    }

    emit VitalSignsChanged();
}

