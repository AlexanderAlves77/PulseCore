#include "Core/Simulation/SimulationController.h"
#include <QRandomGenerator>
#include <QDebug>
#include <QDateTime>
#include <algorithm>
#include <cmath>


/* ======================================================================================== */

SimulationController::SimulationController(QObject * parent)
    : QObject(parent)
{
    updateTimer.setInterval(simulationConfig.updateIntervalMs);

    connect(
        &updateTimer,
        &QTimer::timeout,
        this,
        &SimulationController::UpdateVitalSigns
    );

    connect(
        &simulationClock,
        &SimulationClock::BeatOccurred,
        this,
        &SimulationController::HeartbeatOccurred
    );
}

bool SimulationController::IsRunning() const noexcept
{
    return currentState == SimulationState::RUNNING;
}

/* ======================================================================================== */

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

/* ======================================================================================== */

QString SimulationController::GetScenarioName() const
{
    switch (currentScenario)
    {
    case SimulationScenario::WARNING:
        return QStringLiteral("WARNING");

    case SimulationScenario::CRITICAL:
        return QStringLiteral("CRITICAL");

    case SimulationScenario::NORMAL:
    default:
        return QStringLiteral("NORMAL");
    }
}

/* ======================================================================================== */

int SimulationController::GetHeartRate() const noexcept
{
    return vitalSigns.heartRate;
}

/* ======================================================================================== */

int SimulationController::GetOxygenSaturation() const noexcept
{
    return vitalSigns.oxygenSaturation;
}

/* ======================================================================================== */

int SimulationController::GetRespiratoryRate() const noexcept
{
    return vitalSigns.respiratoryRate;
}

/* ======================================================================================== */

double SimulationController::GetTemperature() const noexcept
{
    return vitalSigns.temperature;
}

/* ======================================================================================== */

void SimulationController::Start()
{
    if (currentState == SimulationState::RUNNING)
    {
        return;
    }

    currentState = SimulationState::RUNNING;

    updateTimer.start();

    simulationClock.SetHeartRate(vitalSigns.heartRate);
    simulationClock.Start();

    LogDebugInfo(
        QStringLiteral("Simulation started. Timer active: %1 | Interval: %2 ms")
            .arg(updateTimer.isActive())
            .arg(updateTimer.interval())
    );

    emit StateChanged();
}

/* ======================================================================================== */

void SimulationController::Pause()
{
    if (currentState != SimulationState::RUNNING)
    {
        return;
    }

    updateTimer.stop();
    simulationClock.Pause();

    LogDebugInfo(QStringLiteral("Simulation paused."));

    currentState = SimulationState::PAUSED;

    emit StateChanged();
}

/* ======================================================================================== */

void SimulationController::Reset()
{
    updateTimer.stop();
    simulationClock.Reset();

    const bool stateChanged = currentState != SimulationState::STOPPED;

    currentState = SimulationState::STOPPED;

    vitalSigns = VitalSigns{};

    LogDebugInfo(QStringLiteral("Simulation reset."));

    if (stateChanged)
    {
        emit StateChanged();
    }

    emit VitalSignsChanged();
}

/* ======================================================================================== */

void SimulationController::SetScenario(const QString& scenarioName)
{
    SimulationScenario nextScenario;

    if (scenarioName == QString("NORMAL"))
    {
        nextScenario = SimulationScenario::NORMAL;
    }
    else if (scenarioName == QString("WARNING"))
    {
        nextScenario = SimulationScenario::WARNING;
    }
    else if (scenarioName == QString("CRITICAL"))
    {
        nextScenario = SimulationScenario::CRITICAL;
    }
    else
    {
        LogDebugInfo(QStringLiteral("Invalid simulation scenario: %1").arg(scenarioName));

        return;
    }

    if (currentScenario == nextScenario)
    {
        return;
    }

    currentScenario = nextScenario;

    simulationConfig = SimulationScenarioFactory::Create(currentScenario);

    updateTimer.setInterval(simulationConfig.updateIntervalMs);

    LogDebugInfo(QStringLiteral("Scenario changed to: %1").arg(GetScenarioName()));

    emit ScenarioChanged();
}

/* ======================================================================================== */

void SimulationController::UpdateVitalSigns()
{
    if (currentState != SimulationState::RUNNING)
    {
        return;
    }

    vitalSigns = vitalSignsGenerator.GenerateNext(vitalSigns, simulationConfig);

    simulationClock.SetHeartRate(vitalSigns.heartRate);

    LogDebugInfo(
        QStringLiteral("HR: %1 | SpO2: %2 | RESP: %3 | TEMP: %4")
            .arg(vitalSigns.heartRate)
            .arg(vitalSigns.oxygenSaturation)
            .arg(vitalSigns.respiratoryRate)
            .arg(vitalSigns.temperature, 0, 'f', 1)
    );

    emit VitalSignsChanged();
}

/* ======================================================================================== */

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
