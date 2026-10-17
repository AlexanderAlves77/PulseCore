#include "Core/Simulation/SimulationController.h"
#include <QRandomGenerator>


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

int SimulationController::GetOxygenSaturation() const noexcept
{
    return vitalSigns.oxygenSaturation;
}

int SimulationController::GetRespiratoryRate() const noexcept
{
    return vitalSigns.respiratoryRate;
}

int SimulationController::GetTemperature() const noexcept
{
    return vitalSigns.temperature;
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

void SimulationController::UpdateVitalSigns()
{
    if (currentState != SimulationState::RUNNING)
    {
        return;
    }

    vitalSigns.heartRate = GenerateVariation(72, 88);

    vitalSigns.oxygenSaturation = GenerateVariation(96, 100);

    vitalSigns.respiratoryRate = GenerateVariation(14, 20);

    const int temperatureTenths = GenerateVariation(365, 372);

    vitalSigns.temperature = static_cast<double>(temperatureTenths) / 10.0;

    emit VitalSignsChanged();
}

int SimulationController::GenerateVariation(int minimum, int maximum) const
{
    return QRandomGenerator::global()->bounded(minimum, maximum + 1);
}
