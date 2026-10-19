import QtQuick

PulseCard {
    id: root

    property string title: "ECG"
    property string unit: "mV"
    property color waveformColor: "#21F58B"

    property alias waveformContent: waveformContainer.data

    cardSize: "LARGE"

    Column {
        anchors.fill: parent
        spacing: 12

        Row {
            width: parent.width
            height: 28

            PulseLabel {
                text: root.title
                labelColor: root.waveformColor
                labelSize: 20
                emphasized: true
            }

            Item {
                width: 12
                height: 1
            }

            PulseLabel {
                text: root.unit
                labelSize: 12
            }
        }

        Item {
            id: waveformContainer

            width: parent.width
            height: Math.max(0, parent.height - 40)
        }
    }
}
