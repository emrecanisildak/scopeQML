#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "radarplotmodel.h"

#include <QVXYModelMapper>

#include <QRandomGenerator64>
#include <QTimer>


int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;


    auto context = engine.rootContext();

    auto radarPlotModel = new RadarPlotModel();
    //auto radarPlotModel2 = new RadarPlotModel();



    auto mapper = new QVXYModelMapper();
    mapper->setModel(radarPlotModel);
    mapper->setXColumn(0);
    mapper->setYColumn(1);

    auto mapper2 = new QVXYModelMapper();
    mapper2->setModel(radarPlotModel);
    mapper2->setXColumn(0);
    mapper2->setYColumn(1);


    auto mapper3 = new QVXYModelMapper();
    mapper3->setModel(radarPlotModel);
    mapper3->setXColumn(0);
    mapper3->setYColumn(2);


    QTimer timer;
    timer.start(100);


    QObject::connect(&timer,&QTimer::timeout,[&radarPlotModel](){
        radarPlotModel->addPlotItem(QRandomGenerator::global()->bounded(0,360),QRandomGenerator::global()->bounded(15,50),QRandomGenerator::global()->bounded(0,200000));

    });
    context->setContextProperty("mapper", mapper);
    context->setContextProperty("mapper2", mapper2);
    context->setContextProperty("mapper3", mapper3);


    const QUrl url(u"qrc:/ScopeQML/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);



    return app.exec();
}
