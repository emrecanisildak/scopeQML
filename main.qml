import QtQuick
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtCharts 2.0


ApplicationWindow{
    width:1350
    height:500
    visible:true
    color:"black"

    Item{
        property alias beamAngle : beam.rotation
        id:scopeQML
        width:parent.width/3
        height:parent.height -50
        anchors.left:parent.left
        anchors.top: parent.top
        // TEST CODEE
        Timer {
            interval: 5; running: true; repeat: true
            onTriggered:
            {

                scopeQML.beamAngle = scopeQML.beamAngle+1;
                bScope.angle = scopeQML.beamAngle
                cScope.angle = scopeQML.beamAngle
            }
        }

        Canvas {
            id: beam
            width: parent.width
            height: parent.height
            z: ppiScope.z + 1
            opacity:0.6
            rotation:0
            onPaint: {
                var plotArea = ppiScope.plotArea
                var ctx = getContext("2d");
                ctx.reset();
                var radius = plotArea.height/2
                var centreX = width/2
                var centreY = height/2
                ctx.beginPath();
                var gradient = ctx.createLinearGradient(centreX,centreY,radius*2,radius*2)
                gradient.addColorStop(0, "green")
                gradient.addColorStop(1, "green")
                ctx.fillStyle = gradient
                ctx.moveTo(centreX, centreY);
                ctx.arc(centreX, centreY,radius, -Math.PI/2 -0.15, -Math.PI/2 + 0.15 , false);
                ctx.lineTo(centreX, centreY);
                ctx.fill();
            }
        }
        PolarChartView {
            id:ppiScope
            title: ""
            anchors.fill: parent
            legend.visible: false
            antialiasing: true
            backgroundColor: "black"
            plotAreaColor: "black"

            ValueAxis {
                id: axisAngular
                min: 0
                max: 360
                tickCount: 10
                color:"green"
                gridLineColor: "green"
                labelsColor: "gray"
            }

            ValueAxis {
                id: axisRadial
                min: 0
                max: 250000
                tickCount:5
                color:"green"
                gridLineColor: "green"
                labelsColor: "gray"
            }

            ScatterSeries {
                id: series2
                axisAngular: axisAngular
                axisRadial: axisRadial
                markerSize: 8
                color: "red"
                borderColor: "red"
                opacity:0.5
                onClicked:
                    // Tıklanılan item pozisyonu
                    console.log(point)

            }

            // Add data dynamically to the series
            Component.onCompleted: {
                // From c++
                mapper.series = series2;

            }

            // TODO ZOOM !!!
        } // scope
    }


    Item{
        property double angle : 0
        id:bScope
        width:parent.width/3
        height:parent.height - 50
        anchors.left:scopeQML.right
        anchors.top: parent.top

        Rectangle{

            id:bScopeBeam
            x:bScopeQML.plotArea.x + ((bScope.angle%360) * bScopeQML.plotArea.width / 360)
            y:bScopeQML.plotArea.y
            height:bScopeQML.plotArea.height
            width:15
            color:"green"
            z:bScopeQML.z+1
            opacity:0.6

        }

        ChartView {
            id:bScopeQML
            title: ""
            anchors.fill: parent
            legend.visible: false
            antialiasing: true
            backgroundColor: "black"
            plotAreaColor: "black"

            ValueAxis {
                id: axisAzimuth
                min: 0
                max: 360
                tickCount: 10
                color:"green"
                gridLineColor: "green"
                labelsColor: "gray"
            }

            ValueAxis {
                id: axisRange
                min: 0
                max: 250000
                tickCount:5
                color:"green"
                gridLineColor: "green"
                labelsColor: "gray"
            }

            ScatterSeries {
                id: series3
                axisAngular: axisAzimuth
                axisRadial: axisRange
                markerSize: 8
                color: "red"
                borderColor: "red"
                opacity:0.5
                onClicked:
                    // Tıklanılan item pozisyonu
                    console.log(point)
            }

            // Add data dynamically to the series
            Component.onCompleted: {
                // From c++
                  mapper2.series = series3;

            }

        }// CHART QML
    }//  B SCOPE

    Item{
        property double angle : 0
        id:cScope
        width:parent.width/3
        height:parent.height - 50
        anchors.left:bScope.right
        anchors.top: parent.top

        Rectangle{
            id:cScopeBeam
            x:cScopeQML.plotArea.x + ((cScope.angle%360) * cScopeQML.plotArea.width / 360)
            y:cScopeQML.plotArea.y
            height:cScopeQML.plotArea.height
            width:15
            color:"green"
            z:cScopeQML.z+1
            opacity:0.6

        }

        ChartView {
            id:cScopeQML
            title: ""
            anchors.fill: parent
            legend.visible: false
            antialiasing: true
            backgroundColor: "black"
            plotAreaColor: "black"

            ValueAxis {
                id: axisAzimuthC
                min: 0
                max: 360
                tickCount: 10
                color:"green"
                gridLineColor: "green"
                labelsColor: "gray"
            }

            ValueAxis {
                id: axisElevation
                min: 15
                max: 50
                tickCount:5
                color:"green"
                gridLineColor: "green"
                labelsColor: "gray"
            }

            ScatterSeries {
                id: series4
                axisAngular: axisAzimuthC
                axisRadial: axisElevation
                markerSize: 8
                color: "red"
                borderColor: "red"
                opacity:0.5
                onClicked:
                    // Tıklanılan item pozisyonu
                    console.log(point)
            }

            // Add data dynamically to the series
            Component.onCompleted: {
                // From c++
                  mapper3.series = series4;

            }

        }// CHART QML
    }//  B SCOPE


}//eND APPLİCATİON
