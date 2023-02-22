#ifndef RADARPLOTMODEL_H
#define RADARPLOTMODEL_H


#include <QAbstractTableModel>
#include <QPointF>
#include <vector>
#include <QTime>
#include <QTimer>


struct PlotItem{
    PlotItem(double az, double el, double r ):
        azimuth(az),elevation(el),range(r)
    {
        timeStamp = QDateTime::currentMSecsSinceEpoch();
    }

    double azimuth;
    double elevation;
    double range;
    uint64_t timeStamp;
};

class RadarPlotModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    RadarPlotModel();

    void addPlotItem(double azimuth, double elevation, double range);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

    void control();

private:
    std::vector<PlotItem> m_data;
    QTimer timer;
};


#endif // RADARPLOTMODEL_H
