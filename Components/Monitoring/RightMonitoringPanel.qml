import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property int heartRate: 0
    property int oxygenSaturation: 0
    property int respiratoryRate: 0
    property real temperature: 0

    property bool running: false
    property bool hasData: false

    ColumnLayout {
        anchors.fill: parent
        spacing: 12

        HeartRateCard {
            id: heartRateCard

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 320
            Layout.minimumHeight: 240

            heartRate: root.heartRate
            running: root.running
            hasData: root.hasData
        }

        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            Layout.preferredHeight: 220

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

                hasData: root.hasData

                minimumCritical: 85
                minimumNormal: 95
                maximumNormal: 100
                maximumCritical: 100
            }

            CompactVitalCard {
                Layout.fillWidth: true
                Layout.fillHeight: true

                title: "RESP"
                value: root.respiratoryRate
                unit: "rpm"
                accentColor: "#FF405D"

                hasData: root.hasData

                minimumCritical: 8
                minimumNormal: 12
                maximumNormal: 20
                maximumCritical: 30
            }

            CompactVitalCard {
                Layout.fillWidth: true
                Layout.fillHeight: true

                title: "TEMP"
                value: root.temperature
                decimals: 1
                unit: "°C"
                accentColor: "#FFE34A"

                hasData: root.hasData

                minimumCritical: 35
                minimumNormal: 36
                maximumNormal: 37.5
                maximumCritical: 39.5
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