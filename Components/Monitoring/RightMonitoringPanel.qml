import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

Item {
    id: root

    PulseTheme {
        id: theme
    }

    // Vital sign data
    property int heartRate: 0

    property real oxygenSaturation: 0.0
    property real respiratoryRate: 0.0
    property real temperature: 0.0

    // Simulation state
    property bool running: false
    property bool hasData: false

    // Layout configuration
    property int panelSpacing: theme.rightPanelSpacing
    property int vitalCardSpacing: theme.rightPanelVitalCardSpacing
    property int heartMinimumHeight: theme.rightPanelHeartMinimumHeight
    property int vitalMinimumHeight: theme.rightPanelVitalMinimumHeight
    property int vitalCardCount: theme.rightPanelVitalCardCount

    property real heartCardRatio: theme.rightPanelHeartRatio

    // Available vertical space
    readonly property real availableHeight: Math.max(0, root.height - root.panelSpacing)

    readonly property real vitalSpacingTotal: root.vitalCardSpacing * (root.vitalCardCount - 1)

    readonly property real preferredHeartHeight: root.availableHeight * root.heartCardRatio

    readonly property real requiredVitalHeight: root.vitalMinimumHeight * root.vitalCardCount
        + root.vitalSpacingTotal

    // Allocate space to the heart without starving the vital cards
    readonly property real heartCardHeight: {
        const maximumHeartHeight = Math.max(
            0,
            root.availableHeight - root.requiredVitalHeight
        )

        const desiredHeartHeight = Math.max(
            root.heartMinimumHeight,
            root.preferredHeartHeight
        )

        return Math.min(desiredHeartHeight, maximumHeartHeight)
    }

    readonly property real vitalPanelHeight: Math.max(0, root.availableHeight - root.heartCardHeight)

    readonly property real compactCardHeight:
        Math.max(
            0,
            (root.vitalPanelHeight - root.vitalSpacingTotal) / root.vitalCardCount
        )

    implicitWidth: theme.rightPanelPreferredWidth
    implicitHeight: theme.rightPanelPreferredHeight

    ColumnLayout {
        id: panelLayout
        anchors.fill: parent
        spacing: root.panelSpacing

        // Heart rate and 3D visualization
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

        // Four vital sign cards
        VitalSignsPanel {
            id: vitalSignsPanel
            Layout.fillWidth: true

            Layout.preferredHeight: root.vitalPanelHeight
            Layout.minimumHeight: 0
            Layout.maximumHeight: root.vitalPanelHeight

            oxygenSaturation: root.oxygenSaturation
            respiratoryRate: root.respiratoryRate
            temperature: root.temperature

            hasSimulationData: root.hasData
            hasCo2Data: false

            cardSpacing: root.vitalCardSpacing
            cardHeight: Math.floor(root.compactCardHeight)
        }
    }

    // Forward heartbeat event to the 3D heart
    function triggerHeartbeat() {
        heartRateCard.triggerHeartbeat()
    }

    // Reset the 3D heart animation
    function resetHeartbeat() {
        heartRateCard.resetHeartbeat()
    }
}
