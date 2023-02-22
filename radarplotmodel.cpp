#include "radarplotmodel.h"
#include <ranges>

RadarPlotModel::RadarPlotModel()
{
    timer.start(300);
    connect(&timer,&QTimer::timeout,this,&RadarPlotModel::control);
}

void RadarPlotModel::addPlotItem(double azimuth, double elevation, double range)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data.emplace_back(azimuth,elevation,range);
    endInsertRows();
}

int RadarPlotModel::rowCount(const QModelIndex &parent) const
{
    return m_data.size();
}

int RadarPlotModel::columnCount(const QModelIndex &parent) const
{
    return 3;
}

QVariant RadarPlotModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    Q_UNUSED(orientation)
    Q_UNUSED(role)
    if(section == 0)
        return "x";
    else
        return "y";
}

QVariant RadarPlotModel::data(const QModelIndex &index, int role) const
{
    Q_UNUSED(role)
    if (index.column() == 0)
        return m_data[index.row()].azimuth;
    else if(index.column() == 1)
        return m_data[index.row()].range;
    else if(index.column() == 2)
        return m_data[index.row()].elevation;

}

void RadarPlotModel::control()
{
    beginResetModel();
    auto f = [](PlotItem& item){ return QDateTime::currentMSecsSinceEpoch() -  item.timeStamp > 3000; };
    m_data.erase(std::remove_if(m_data.begin(), m_data.end(), f), m_data.end());
    endResetModel();
}
