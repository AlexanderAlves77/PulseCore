import QtQuick
import QtQuick.Layouts

Item {
    id: root

    PulseTheme {
        id: theme
    }

    // Vital sign data
    property int heartRate: 0
    property int oxygenSaturation: 0
    property int respiratoryRate: 0
    property real temperature: 0.0

    // Data availability
    property bool hasData: true

    // Grid configuration
    property int gridColumns: 2
    property int gridSpacing: theme.spacingMedium

    // Card typography
    property int vitalValueSize: 46

    // Default dimensions
    implicitWidth: 440
    implicitHeight: 310

    GridLayout {
        id: vitalGrid

        anchors.fill: parent

        columns: root.gridColumns
        rowSpacing: root.gridSpacing
        columnSpacing: root.gridSpacing

        VitalSignCard {
            title: "SpO₂"
            value: root.oxygenSaturation
            unit: "%"

            hasData: root.hasData
            accentColor: theme.oxygenColor
            valueSize: root.vitalValueSize

            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        VitalSignCard {
            title: "Respiratory Rate"
            value: root.respiratoryRate
            unit: "rpm"

            hasData: root.hasData
            accentColor: theme.respiratoryColor
            valueSize: root.vitalValueSize

            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        VitalSignCard {
            title: "Temperature"
            value: root.temperature
            unit: "°C"

            hasData: root.hasData
            decimals: 1

            accentColor: theme.temperatureColor
            valueSize: root.vitalValueSize

            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        VitalSignCard {
            title: "Heart Rate"
            value: root.heartRate
            unit: "bpm"

            hasData: root.hasData
            accentColor: theme.heartRateColor
            valueSize: root.vitalValueSize

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
