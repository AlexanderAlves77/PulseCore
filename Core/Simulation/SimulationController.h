#pragma once

#include <QObject>
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

private:
    SimulationState currentState = SimulationState::STOPPED;
    VitalSigns vitalSigns;

public:
    explicit SimulationController(QObject * parent = nullptr);

    bool IsRunning() const noexcept;

    QString GetStateName() const;

    int GetHeartRate() const noexcept;

    Q_INVOKABLE void Start();
    Q_INVOKABLE void Pause();
    Q_INVOKABLE void Reset();

signals:
    void StateChanged();
    void VitalSignsChanged();
};
