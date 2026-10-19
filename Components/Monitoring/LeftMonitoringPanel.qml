import QtQuick
import QtQuick.Layouts

import "../DesignSystem"
import "../../"

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        WaveformCard {
            id: ecgCard

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 2

            title: "ECG"
            unit: "Lead II · mV"
            waveformColor: "#21F58B"

            EcgWaveform {
                id: ecgWaveform
                anchors.fill: parent
                waveformColor: ecgCard.waveformColor
            }
        }

        Repeater {
            model: [
                { title: "SpO₂", unit: "Pleth", color: "#00DDF2" },
                { title: "RESP", unit: "Respiration", color: "#FF405D" },
                { title: "CO₂", unit: "Capnography", color: "#FFE34A" }
            ]

            delegate: WaveformCard {
                required property var modelData

                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: 1

                title: modelData.title
                unit: modelData.unit
                waveformColor: modelData.color

                PulseLabel {
                    anchors.centerIn: parent
                    text: "SIGNAL NOT IMPLEMENTED"
                    labelSize: 12
                    labelColor: "#648398"
                }
            }
        }
    }

    function addEcgSample(sample) {
        ecgWaveform.addSample(sample)
    }

    function clearEcgSamples() {
        ecgWaveform.clearSamples()
    }
}
