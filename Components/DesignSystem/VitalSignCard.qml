import QtQuick

PulseCard {
    id: root

    property string title: "Heart Rate"
    property real value: 78
    property string unit: "bpm"
    property string status: "NORMAL"

    property color accentColor: "#21F58B"
    property int valueSize: 56

    cardSize: "MEDIUM"

    Column {
        anchors.fill: parent
        spacing: 8

        PulseLabel {
            text: root.title
            labelColor: "#9AB6C8"
            labelSize: 15
        }

        Row {
            width: parent.width
            spacing: 16

            PulseNumber {
                value: root.value
                unit: root.unit
                valueColor: root.accentColor
                valueSize: root.valueSize
            }

            PulseBadge {
                status: root.status
            }
        }
    }
}