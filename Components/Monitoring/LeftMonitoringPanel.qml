import QtQuick
import QtQuick.Layouts

import "../DesignSystem"
import PulseCore

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        WaveformCard {
            id: ecgCard

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 180
            Layout.minimumHeight: 90

            title: "ECG"
            unit: "Lead II · mV"
            waveformColor: "#21F58B"

            waveformDelegate: EcgWaveform {
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
                Layout.preferredHeight: 120
                Layout.minimumHeight: 75

                title: modelData.title
                unit: modelData.unit
                waveformColor: modelData.color

                waveformDelegate: WaveformPlaceholder {
                    message: "SIGNAL NOT IMPLEMENTED"
                }
            }
        }
    }

    function addEcgSample(sample) {
        if (ecgCard.waveformItem)
            ecgCard.waveformItem.addSample(sample)
    }

    function clearEcgSamples() {
        if (ecgCard.waveformItem)
            ecgCard.waveformItem.clearSamples()
    }
}
