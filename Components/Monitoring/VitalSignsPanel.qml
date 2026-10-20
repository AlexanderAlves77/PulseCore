import QtQuick
import QtQuick.Layouts
import "../Controls"

Item {
    id: root

    property string oxygenStatus: "NORMAL"
    property string respiratoryStatus: "NORMAL"
    property string co2Status: "NORMAL"
    property string temperatureStatus: "NORMAL"

    property int cardSpacing: 8
    property int cardHeight: 72

    property real endTidalCo2: 0.0
    property real oxygenSaturation: 0.0
    property real respiratoryRate: 0.0
    property real temperature: 0.0

    property bool hasSimulationData: false
    property bool hasCo2Data: false

    implicitWidth: 500
    implicitHeight: cardsLayout.implicitHeight

    ColumnLayout {
        id: cardsLayout

        anchors.fill: parent
        spacing: root.cardSpacing

        VitalMonitorCard {
            Layout.fillWidth: true
            Layout.preferredHeight: root.cardHeight

            title: "Oxygen Saturation"
            subtitle: "SpO₂ %"
            iconName: "heart"

            value: root.oxygenSaturation
            decimals: 0
            hasData: root.hasSimulationData

            accentColor: "#00DDF2"
            status: root.oxygenStatus

            showScale: true
            scaleMaximum: 100
            scaleMinimum: 85

            showDetails: false
        }

        VitalMonitorCard {
            Layout.fillWidth: true
            Layout.preferredHeight: root.cardHeight

            title: "Respiratory Rate"
            subtitle: "rpm"
            iconName: "ecg"

            value: root.respiratoryRate
            decimals: 0
            hasData: root.hasSimulationData

            accentColor: "#FF405D"
            status: root.respiratoryStatus

            showScale: true
            scaleMaximum: 50
            scaleMinimum: 0

            showDetails: false
        }

        VitalMonitorCard {
            Layout.fillWidth: true
            Layout.preferredHeight: root.cardHeight

            title: "End Tidal CO₂"
            subtitle: "EtCO₂ mmHg"
            iconName: "ecg"

            value: root.endTidalCo2
            decimals: 0
            hasData: root.hasCo2Data

            accentColor: "#FFB020"
            status: root.co2Status

            showScale: true
            scaleMaximum: 50
            scaleMinimum: 0

            showDetails: false
        }

        VitalMonitorCard {
            Layout.fillWidth: true
            Layout.preferredHeight: root.cardHeight

            title: "Temperature"
            subtitle: "°C"
            iconName: "heart"

            value: root.temperature
            decimals: 1
            hasData: root.hasSimulationData

            accentColor: "#FFE34A"
            status: root.temperatureStatus

            showScale: false
            showDetails: false
        }
    }
}
