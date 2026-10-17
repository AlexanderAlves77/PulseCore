#pragma once

#include <QObject>
#include <QTimer>
#include "Core/Enums/SimulationState.h"
#include "Core/Models/VitalSigns.h"

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
        int temperature
        READ GetTemperature
        NOTIFY VitalSignsChanged
    )

private:
    SimulationState currentState = SimulationState::STOPPED;
    VitalSigns vitalSigns;
    QTimer updateTimer;

    int GenerateVariation(int minimum, int maximum) const;
    int GenerateNextValue(int currentValue, int minimum, int maximum, int maximumVariation) const;

    void LogDebugInfo(const QString& message) const;

public:
    explicit SimulationController(QObject * parent = nullptr);

    bool IsRunning() const noexcept;
    QString GetStateName() const;

    int GetHeartRate() const noexcept;
    int GetOxygenSaturation() const noexcept;
    int GetRespiratoryRate() const noexcept;
    double GetTemperature() const noexcept;

    Q_INVOKABLE void Start();
    Q_INVOKABLE void Pause();
    Q_INVOKABLE void Reset();

signals:
    void StateChanged();
    void VitalSignsChanged();

private slots:
    void UpdateVitalSigns();
};
