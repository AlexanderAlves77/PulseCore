import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property int heartRate: 0
    property int oxygenSaturation: 0
    property int respiratoryRate: 0
    property real temperature: 0

    implicitWidth: 440
    implicitHeight: 310

    GridLayout {
        anchors.fill: parent

        columns: 2
        rowSpacing: 12
        columnSpacing: 12

        VitalSignCard {
            Layout.fillWidth: true
            Layout.fillHeight: true

            title: "SpO₂"
            value: root.oxygenSaturation
            unit: "%"
            accentColor: "#00DDF2"
            valueSize: 46
        }

        VitalSignCard {
            Layout.fillWidth: true
            Layout.fillHeight: true

            title: "Respiratory Rate"
            value: root.respiratoryRate
            unit: "rpm"
            accentColor: "#FF405D"
            valueSize: 46
        }

        VitalSignCard {
            Layout.fillWidth: true
            Layout.fillHeight: true

            title: "Temperature"
            value: root.temperature
            unit: "°C"
            accentColor: "#FFE34A"
            valueSize: 46
        }

        VitalSignCard {
            Layout.fillWidth: true
            Layout.fillHeight: true

            title: "Heart Rate"
            value: root.heartRate
            unit: "bpm"
            accentColor: "#21F58B"
            valueSize: 46
        }
    }
}
