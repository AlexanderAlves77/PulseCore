#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QUrl>
#include "Core/Simulation/SimulationController.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    SimulationController simulationController;

    QQmlApplicationEngine engine;  

    engine.rootContext()->setContextProperty(
        "simulationController",
        &simulationController
    );

    engine.loadFromModule("PulseCore", "Main");

    if (engine.rootObjects().isEmpty())
    {
        return -1;
    }

    return app.exec();
}
