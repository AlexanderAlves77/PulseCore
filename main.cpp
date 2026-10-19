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

    /*
    const QMetaObject* metaObject = simulationController.metaObject();

    for (int index = metaObject->methodOffset();
         index < metaObject->methodCount();
         ++index)
    {
        const QMetaMethod method = metaObject->method(index);

        qDebug() << method.methodSignature();
    } */

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
