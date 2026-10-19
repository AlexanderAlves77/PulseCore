#include <QtTest/QTest>
#include <QtTest/QSignalSpy>
#include "Core/Simulation/SimulationClock.h"

/* ======================================================================================== */

class SimulationClockTests final : public QObject
{
    Q_OBJECT

private slots:
    void ShouldStartAndPause();
    void ShouldEmitTicks();
    void ShouldEmitHeartbeats();
    void ShouldResetElapsedTime();
};

/* ======================================================================================== */

void SimulationClockTests::ShouldStartAndPause()
{
    SimulationClock clock;

    QVERIFY(!clock.IsRunning());

    clock.Start();
    QVERIFY(clock.IsRunning());

    clock.Pause();
    QVERIFY(!clock.IsRunning());
}

/* ======================================================================================== */

void SimulationClockTests::ShouldEmitTicks()
{
    SimulationClock clock;

    QSignalSpy tickSpy(&clock, &SimulationClock::Tick);

    QVERIFY(tickSpy.isValid());

    clock.Start();

    QTRY_VERIFY_WITH_TIMEOUT(tickSpy.count() > 0, 1000);

    clock.Pause();
}

/* ======================================================================================== */

void SimulationClockTests::ShouldEmitHeartbeats()
{
    SimulationClock clock;

    clock.SetHeartRate(120);

    QSignalSpy heartbeatSpy(&clock, &SimulationClock::BeatOccurred);

    QVERIFY(heartbeatSpy.isValid());

    clock.Start();

    QTRY_VERIFY_WITH_TIMEOUT(heartbeatSpy.count() >= 2, 2500);

    clock.Pause();
}

/* ======================================================================================== */

void SimulationClockTests::ShouldResetElapsedTime()
{
    SimulationClock clock;

    clock.Start();

    QTest::qWait(100);

    clock.Reset();

    QVERIFY(!clock.IsRunning());

    QCOMPARE(clock.GetElapsedSeconds(), 0.0);
}

/* ======================================================================================== */

QTEST_GUILESS_MAIN(SimulationClockTests)

#include "SimulationClockTests.moc"