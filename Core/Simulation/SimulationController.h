#pragma once

#include <QObject>
#include <QTimer>
#include "Core/Enums/SimulationState.h"
#include "Core/Models/VitalSigns.h"
#include "Core/Simulation/VitalSignsGenerator.h"
#include "Core/Simulation/SimulationConfig.h"
#include "Core/Enums/SimulationScenario.h"
#include "Core/Simulation/SimulationClock.h"
#include "Core/Simulation/SimulationScenarioFactory.h"


class SimulationController final : public QObject
{
    Q_OBJECT

    Q_PROPERTY(
        bool running
        READ IsRunning
        NOTIFY StateChanged
    )

    Q_PROPERTY(
        QString state
        READ GetStateName
        NOTIFY StateChanged
    )

    Q_PROPERTY(
        int heartRate
        READ GetHeartRate
        NOTIFY VitalSignsChanged
    )

    Q_PROPERTY(
        int oxygenSaturation
        READ GetOxygenSaturation
        NOTIFY VitalSignsChanged
    )

    Q_PROPERTY(
        int respiratoryRate
        READ GetRespiratoryRate
        NOTIFY VitalSignsChanged
    )

    Q_PROPERTY(
        double temperature
        READ GetTemperature
        NOTIFY VitalSignsChanged
    )

    Q_PROPERTY(
        QString scenario
        READ GetScenarioName
        NOTIFY ScenarioChanged
    )

private:
    VitalSignsGenerator vitalSignsGenerator;
    SimulationConfig simulationConfig;
    SimulationClock simulationClock;
    VitalSigns vitalSigns;
    QTimer updateTimer;

    SimulationState currentState = SimulationState::STOPPED;
    SimulationScenario currentScenario = SimulationScenario::NORMAL;

    void LogDebugInfo(const QString& message) const;

public:
    explicit SimulationController(QObject * parent = nullptr);

    bool IsRunning() const noexcept;
    QString GetStateName() const;
    QString GetScenarioName() const;

    int GetHeartRate() const noexcept;
    int GetOxygenSaturation() const noexcept;
    int GetRespiratoryRate() const noexcept;
    double GetTemperature() const noexcept;

    Q_INVOKABLE void Start();
    Q_INVOKABLE void Pause();
    Q_INVOKABLE void Reset();
    Q_INVOKABLE void SetScenario(const QString& scenarioName);

signals:
    void StateChanged();
    void VitalSignsChanged();
    void ScenarioChanged();
    void HeartbeatOccurred();

private slots:
    void UpdateVitalSigns();
};
