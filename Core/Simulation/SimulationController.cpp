#include "Core/Simulation/SimulationController.h"
#include <QRandomGenerator>
#include <QDebug>
#include <QDateTime>
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

    LogDebugInfo(
        QStringLiteral("Simulation started. Timer active: %1 | Interval: %2 ms")
            .arg(updateTimer.isActive())
            .arg(updateTimer.interval())
    );

    emit StateChanged();
}

void SimulationController::Pause()
{
    if (currentState != SimulationState::RUNNING)
    {
        return;
    }

    updateTimer.stop();

    LogDebugInfo(QStringLiteral("Simulation paused."));

    currentState = SimulationState::PAUSED;

    emit StateChanged();
}

void SimulationController::Reset()
{
    updateTimer.stop();

    const bool stateChanged = currentState != SimulationState::STOPPED;

    currentState = SimulationState::STOPPED;

    vitalSigns = VitalSigns();

    LogDebugInfo(QStringLiteral("Simulation reset."));

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

    vitalSigns = vitalSignsGenerator.GenerateNext(vitalSigns);

    LogDebugInfo(
        QStringLiteral("HR: %1 | SpO2: %2 | RESP: %3 | TEMP: %4")
            .arg(vitalSigns.heartRate)
            .arg(vitalSigns.oxygenSaturation)
            .arg(vitalSigns.respiratoryRate)
            .arg(vitalSigns.temperature, 0, 'f', 1)
    );

    emit VitalSignsChanged();
}

void SimulationController::LogDebugInfo(const QString& message) const
{
#ifdef QT_DEBUG
    qDebug().noquote()
        << QDateTime::currentDateTime().toString("HH:mm:ss")
        << "[SimulationController]"
        << message;
#else
    Q_UNUSED(message);
#endif
}
