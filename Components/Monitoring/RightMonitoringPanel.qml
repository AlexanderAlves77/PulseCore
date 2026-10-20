import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property int heartRate: 0
    property int panelSpacing: 10
    property int vitalCardSpacing: 8

    property real oxygenSaturation: 0.0
    property real respiratoryRate: 0.0
    property real temperature: 0
    property real heartCardRatio: 0.34

    property bool running: false
    property bool hasData: false

    readonly property real availableHeight: Math.max(0, height - panelSpacing)

    readonly property real heartCardHeight: Math.max(0, availableHeight * heartCardRatio)

    readonly property real vitalPanelHeight: Math.max(0, availableHeight - heartCardHeight)

    readonly property real compactCardHeight: Math.max(
        0, (vitalPanelHeight - vitalCardSpacing * 3) / 4
    )

    implicitWidth: 500
    implicitHeight: 620

    ColumnLayout {
        id: panelLayout
        anchors.fill: parent
        spacing: root.panelSpacing

        HeartRateCard {
            id: heartRateCard

            Layout.fillWidth: true
            Layout.preferredHeight: root.heartCardHeight
            Layout.minimumHeight: 0
            Layout.maximumHeight: root.heartCardHeight

            heartRate: root.heartRate
            running: root.running
            hasData: root.hasData
        }

        VitalSignsPanel {
            id: vitalSignsPanel

            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.minimumHeight: 0
            Layout.preferredHeight: root.vitalPanelHeight

            oxygenSaturation: root.oxygenSaturation
            respiratoryRate: root.respiratoryRate
            temperature: root.temperature

            hasSimulationData: root.hasData
            hasCo2Data: false

            cardSpacing: root.vitalCardSpacing
            cardHeight: Math.floor(root.compactCardHeight)
        }
    }

    function triggerHeartbeat() {
        heartRateCard.triggerHeartbeat()
    }

    function resetHeartbeat() {
        heartRateCard.resetHeartbeat()
    }
}