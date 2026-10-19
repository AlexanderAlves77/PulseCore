import QtQuick
import QtQuick.Layouts

PulseCard {
    id: root

    property string title: "ECG"
    property string unit: "mV"
    property color waveformColor: "#21F58B"

    property alias waveformContent: waveformContainer.data

    cardSize: "MEDIUM"

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 24
            spacing: 10

            PulseLabel {
                text: root.title
                labelColor: root.waveformColor
                labelSize: 16
                emphasized: true
            }

            PulseLabel {
                text: root.unit
                labelSize: 12
            }

            Item {
                Layout.fillWidth: true
            }
        }

        Item {
            id: waveformContainer

            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
        }
    }
}