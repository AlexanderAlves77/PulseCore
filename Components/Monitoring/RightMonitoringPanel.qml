import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property int heartRate: 0
    property int panelSpacing: 12
    property int heartCardHeight: 210

    property real oxygenSaturation: 0.0
    property real respiratoryRate: 0.0
    property real temperature: 0

    property bool running: false
    property bool hasSimulationData: false

    implicitWidth: 500
    implicitHeight: 620

    ColumnLayout {
        anchors.fill: parent
        spacing: root.panelSpacing

        HeartRateCard {
            id: heartRateCard

            Layout.fillWidth: true
            Layout.preferredHeight: root.heartCardHeight

            heartRate: root.heartRate
            running: root.running
            hasData: root.hasSimulationData
        }

        VitalSignsPanel {
            id: vitalSignsPanel

            Layout.fillWidth: true
            Layout.fillHeight: true

            oxygenSaturation: root.oxygenSaturation
            respiratoryRate: root.respiratoryRate
            temperature: root.temperature

            hasSimulationData: root.hasSimulationData

            // CO2 data is not available in the simulator yet.
            hasCo2Data: false
        }
    }

    function triggerHeartbeat() {
        heartRateCard.triggerHeartbeat()
    }

    function resetHeartbeat() {
        heartRateCard.resetHeartbeat()
    }
}