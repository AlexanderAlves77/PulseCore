import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property int heartRate: 0
    property int oxygenSaturation: 0
    property int respiratoryRate: 0
    property real temperature: 0

    property bool running: false

    ColumnLayout {
        anchors.fill: parent
        spacing: 12

        HeartRateCard {
            id: heartRateCard

            Layout.fillWidth: true
            Layout.preferredHeight: 300

            heartRate: root.heartRate
            running: root.running
        }

        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            columns: 2
            rowSpacing: 12
            columnSpacing: 12

            CompactVitalCard {
                Layout.fillWidth: true
                Layout.fillHeight: true

                title: "SpO₂"
                value: root.oxygenSaturation
                unit: "%"
                accentColor: "#00DDF2"
            }

            CompactVitalCard {
                Layout.fillWidth: true
                Layout.fillHeight: true

                title: "RESP"
                value: root.respiratoryRate
                unit: "rpm"
                accentColor: "#FF405D"
            }

            CompactVitalCard {
                Layout.fillWidth: true
                Layout.fillHeight: true

                title: "TEMP"
                value: root.temperature
                decimals: 1
                unit: "°C"
                accentColor: "#FFE34A"
            }
        }
    }

    function triggerHeartbeat() {
        heartRateCard.triggerHeartbeat()
    }

    function resetHeartbeat() {
        heartRateCard.resetHeartbeat()
    }
}