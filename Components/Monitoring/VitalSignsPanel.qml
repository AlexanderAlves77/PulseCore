import QtQuick
import PulseCore

Row {
    id: root
    height: 145
    spacing: 16

    property int heartRate: 0
    property int oxygenSaturation: 0
    property int respiratoryRate: 0
    property real temperature: 0.0

    VitalCard {
        width: (root.width - root.spacing * 3) / 4
        height: root.height

        label: "HR"
        value: root.heartRate.toString()
        unit: "bpm"
        accentColor: "#40DCA5"
    }

    VitalCard {
        width: (root.width - root.spacing * 3) / 4
        height: root.height

        label: "SpO₂"
        value: root.oxygenSaturation.toString()
        unit: "%"
        accentColor: "#61B8FA"
    }

    VitalCard {
        width: (root.width - root.spacing * 3) / 4
        height: root.height

        label: "RESP"
        value: root.respiratoryRate.toString()
        unit: "rpm"
        accentColor: "#F0B75E"
    }

    VitalCard {
        width: (root.width - root.spacing * 3) / 4
        height: root.height

        label: "TEMP"
        value: root.temperature.toFixed(1)
        unit: "°C"
        accentColor: "#E9A6F4"
    }
}
