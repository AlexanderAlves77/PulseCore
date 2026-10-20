import QtQuick
import QtQuick.Layouts

import "../Controls"
import "../DesignSystem"

Item {
    id: root

    PulseTheme {
        id: theme
    }

    // Clinical statuses
    property string oxygenStatus: "NORMAL"
    property string respiratoryStatus: "NORMAL"
    property string co2Status: "NORMAL"
    property string temperatureStatus: "NORMAL"

    // Layout
    property int cardSpacing: theme.vitalSignsPanelSpacing
    property int cardHeight: theme.vitalSignsPanelCardHeight

    // Signal quality
    property int signalStrength: 0

    // Primary measurements
    property real oxygenSaturation: 0.0
    property real respiratoryRate: 0.0
    property real temperature: 0.0
    property real endTidalCo2: 0.0

    // Additional measurements
    property real perfusionIndex: 0.0
    property real airwayRespiratoryRate: 0.0

    // Temperature measurements
    property real temperatureT1: 0.0
    property real temperatureT2: 0.0
    property real temperatureDelta: 0.0

    // Data availability
    property bool hasSimulationData: false
    property bool hasCo2Data: false
    property bool hasSignalData: false
    property bool hasPerfusionIndexData: false
    property bool hasAirwayRespiratoryRateData: false

    // Temperature data availability
    property bool hasTemperatureT1: false
    property bool hasTemperatureT2: false
    property bool hasTemperatureDelta: false

    // Computed layout
    readonly property real totalSpacing: root.cardSpacing * 3

    readonly property real availableCardHeight:
        Math.max(0, (root.height - root.totalSpacing) / 4)

    readonly property real effectiveCardHeight:
        Math.min(root.cardHeight, root.availableCardHeight)

    implicitWidth: theme.vitalSignsPanelPreferredWidth

    implicitHeight: root.cardHeight * 4 + root.totalSpacing

    ColumnLayout {
        id: cardsLayout

        anchors.fill: parent
        spacing: root.cardSpacing

        // Oxygen saturation
        VitalMonitorCard {
            id: oxygenCard

            Layout.fillWidth: true
            Layout.preferredHeight: root.effectiveCardHeight
            Layout.minimumHeight: 0
            Layout.maximumHeight: root.effectiveCardHeight

            title: theme.oxygenMonitorTitle
            subtitle: theme.oxygenMonitorSubtitle
            iconName: theme.oxygenMonitorIcon

            value: root.oxygenSaturation
            decimals: 0
            hasData: root.hasSimulationData

            accentColor: theme.oxygenColor
            status: root.oxygenStatus

            showScale: true
            scaleMinimum: theme.oxygenScaleMinimum
            scaleMaximum: theme.oxygenScaleMaximum

            showDetails: root.hasPerfusionIndexData
            detailTitle: theme.perfusionIndexLabel
            detailValue: root.hasPerfusionIndexData
                         ? root.perfusionIndex.toFixed(1) : theme.monitorUnavailableValue

            showSignal: root.hasSignalData
            signalStrength: root.signalStrength

            showTemperatureDetails: false
        }

        // Respiratory rate
        VitalMonitorCard {
            id: respiratoryCard

            Layout.fillWidth: true
            Layout.preferredHeight: root.effectiveCardHeight
            Layout.minimumHeight: 0
            Layout.maximumHeight: root.effectiveCardHeight

            title: theme.respiratoryMonitorTitle
            subtitle: theme.respiratoryMonitorSubtitle
            iconName: theme.respiratoryMonitorIcon

            value: root.respiratoryRate
            decimals: 0
            hasData: root.hasSimulationData

            accentColor: theme.respiratoryColor
            status: root.respiratoryStatus

            showScale: true
            scaleMinimum: theme.respiratoryScaleMinimum
            scaleMaximum: theme.respiratoryScaleMaximum

            showDetails: false
            showSignal: false
            showTemperatureDetails: false
        }

        // End tidal CO2
        VitalMonitorCard {
            id: co2Card

            Layout.fillWidth: true
            Layout.preferredHeight: root.effectiveCardHeight
            Layout.minimumHeight: 0
            Layout.maximumHeight: root.effectiveCardHeight

            title: theme.co2MonitorTitle
            subtitle: theme.co2MonitorSubtitle
            iconName: theme.co2MonitorIcon

            value: root.endTidalCo2
            decimals: 0
            hasData: root.hasCo2Data

            accentColor: theme.co2Color
            status: root.co2Status

            showScale: true
            scaleMinimum: theme.co2ScaleMinimum
            scaleMaximum: theme.co2ScaleMaximum

            showDetails: root.hasAirwayRespiratoryRateData
            detailTitle: theme.airwayRespiratoryRateLabel
            detailValue: root.hasAirwayRespiratoryRateData
                         ? root.airwayRespiratoryRate.toFixed(0)
                         : theme.monitorUnavailableValue

            showSignal: false
            showTemperatureDetails: false
        }

        // Temperature
        VitalMonitorCard {
            id: temperatureCard

            Layout.fillWidth: true
            Layout.preferredHeight: root.effectiveCardHeight
            Layout.minimumHeight: 0
            Layout.maximumHeight: root.effectiveCardHeight

            title: theme.temperatureMonitorTitle
            subtitle: theme.temperatureMonitorSubtitle
            iconName: theme.temperatureMonitorIcon

            value: root.temperature
            decimals: 1
            hasData: root.hasSimulationData

            accentColor: theme.temperatureColor
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
