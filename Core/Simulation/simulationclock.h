#ifndef SIMULATIONCLOCK_H
#define SIMULATIONCLOCK_H

#include <QObject>
#include <QElapsedTimer>
#include <QTimer>

class SimulationClock final : public QObject
{
    Q_OBJECT

private:
    static constexpr int TICK_INTERVAL_MS = 16;
    static constexpr int DEFAULT_HEART_RATE = 78;

    QTimer tickTimer;
    QElapsedTimer elapsedTimer;

    double accumulatedSeconds = 0.0;
    double beatPhaseSeconds = 0.0;
    double previousSeconds = 0.0;
    double beatIntervalSeconds = 60.0 / DEFAULT_HEART_RATE;

    bool running = false;

public:
    explicit SimulationClock(QObject * parent = nullptr);

    void Start();
    void Pause();
    void Reset();

    void SetHeartRate(int heartRate);

    bool IsRunning() const noexcept;
    double GetElapsedSeconds() const noexcept;

signals:
    void Tick(double elapsedSeconds);
    void BeatOccurred(double elapsedSeconds);

private slots:
    void Update();
};

#endif // SIMULATIONCLOCK_H
