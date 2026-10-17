#include "Core/Simulation/SimulationController.h"
#include <QRandomGenerator>
#include <QDebug>
#include <algorithm>
#include <cmath>


SimulationController::SimulationController(QObject * parent)
    : QObject(parent)
{
    updateTimer.setInterval(1000);

    connect(
        &updateTimer,
        &QTimer::timeout,
        this,
        &SimulationController::UpdateVitalSigns
    );
}

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

double SimulationController::GetTemperature() const noexcept
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

    updateTimer.start();

    qDebug() << "Simulation started."
             << "Timer active:" << updateTimer.isActive()
             << "Interval:" << updateTimer.interval();

    emit StateChanged();
}

void SimulationController::Pause()
{
    if (currentState != SimulationState::RUNNING)
    {
        return;
    }

    updateTimer.stop();

    currentState = SimulationState::PAUSED;

    emit StateChanged();
}

void SimulationController::Reset()
{
    updateTimer.stop();

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

    qDebug() << "Updating vital signs...";

    vitalSigns.heartRate = GenerateNextValue(vitalSigns.heartRate, 72, 88, 2);

    vitalSigns.oxygenSaturation = GenerateNextValue(vitalSigns.oxygenSaturation, 96, 100, 1);

    vitalSigns.respiratoryRate = GenerateNextValue(vitalSigns.respiratoryRate, 14, 20, 1);

    const int currentTemperatureTenths = static_cast<int>(std::lround(vitalSigns.temperature * 10.0));

    const int nexttemperatureTenths = GenerateNextValue(currentTemperatureTenths, 365, 372, 1);

    vitalSigns.temperature = static_cast<double>(nexttemperatureTenths) / 10.0;

    qDebug() << "HR:" << vitalSigns.heartRate
             << "SpO2:" << vitalSigns.oxygenSaturation
             << "RESP:" << vitalSigns.respiratoryRate
             << "TEMP:" << vitalSigns.temperature;

    emit VitalSignsChanged();
}

int SimulationController::GenerateVariation(int minimum, int maximum) const
{
    return QRandomGenerator::global()->bounded(minimum, maximum + 1);
}

int SimulationController::GenerateNextValue(int currentValue, int minimum,
    int maximum, int maximumVariation) const
{
    const int variation = GenerateVariation(-maximumVariation, maximumVariation);

    const int nextValue = currentValue + variation;

    return std::clamp(nextValue, variation, maximum);
}
