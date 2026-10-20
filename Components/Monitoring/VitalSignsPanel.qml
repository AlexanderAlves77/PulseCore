
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
    property int signalStrength: 0

    property real oxygenSaturation: 0.0
    property real respiratoryRate: 0.0
    property real temperature: 0.0
    property real endTidalCo2: 0.0
    property real perfusionIndex: 0.0
    property real airwayRespiratoryRate: 0.0
    property real temperatureT1: 0.0
    property real temperatureT2: 0.0
    property real temperatureDelta: 0.0

    property bool hasSimulationData: false
    property bool hasCo2Data: false
    property bool hasSignalData: false
    property bool hasPerfusionIndexData: false
    property bool hasAirwayRespiratoryRateData: false

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
            subtitle: "SpO2 %"
            iconName: "lungs"

            value: root.oxygenSaturation
            decimals: 0
            hasData: root.hasSimulationData

            accentColor: "#00DDF2"
            status: root.oxygenStatus

            showScale: true
            scaleMaximum: 100
            scaleMinimum: 85

            showDetails: root.hasPerfusionIndexData
            detailTitle: "PI"
            detailValue: root.hasPerfusionIndexData
                         ? root.perfusionIndex.toFixed(1)
                         : "--"

            showSignal: root.hasSignalData
            signalStrength: root.signalStrength

            showTemperatureDetails: false
        }

        VitalMonitorCard {
            Layout.fillWidth: true
            Layout.preferredHeight: root.cardHeight

            title: "Respiratory Rate"
            subtitle: "rpm"
            iconName: "lungs"

            value: root.respiratoryRate
            decimals: 0
            hasData: root.hasSimulationData

            accentColor: "#FF405D"
            status: root.respiratoryStatus

            showScale: true
            scaleMaximum: 50
            scaleMinimum: 0

            showDetails: false
            showSignal: false
            showTemperatureDetails: false
        }

        VitalMonitorCard {
            Layout.fillWidth: true
            Layout.preferredHeight: root.cardHeight

            title: "End Tidal CO2"
            subtitle: "EtCO2 mmHg"
            iconName: "lungs"

            value: root.endTidalCo2
            decimals: 0
            hasData: root.hasCo2Data

            accentColor: "#FFB020"
            status: root.co2Status

            showScale: true
            scaleMaximum: 50
            scaleMinimum: 0

            showDetails: root.hasAirwayRespiratoryRateData
            detailTitle: "awRR"
            detailValue: root.hasAirwayRespiratoryRateData
                         ? root.airwayRespiratoryRate.toFixed(0)
                         : "--"

            showSignal: false
            showTemperatureDetails: false
        }

        VitalMonitorCard {
            Layout.fillWidth: true
            Layout.preferredHeight: root.cardHeight

            title: "Temperature"
            subtitle: "°C"
            iconName: "thermometer"

            value: root.temperature
            decimals: 1
            hasData: root.hasSimulationData

            accentColor: "#FFE34A"
            status: root.temperatureStatus

            showScale: false
            showDetails: false
            showSignal: false

            showTemperatureDetails: true

            temperatureT1: root.temperatureT1
            temperatureT2: root.temperatureT2
            temperatureDelta: root.temperatureDelta

            hasTemperatureT1: root.hasTemperatureT1
            hasTemperatureT2: root.hasTemperatureT2
            hasTemperatureDelta: root.hasTemperatureDelta
        }
    }
}
