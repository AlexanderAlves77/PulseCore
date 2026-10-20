import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

PulseCard {
    id: root

    PulseTheme {
        id: theme
    }

    // Simulation data
    property int heartRate: 0
    property bool running: false
    property bool hasData: false

    // Clinical status
    readonly property string status: heartRateStatus.status
    readonly property color statusColor: heartRateStatus.statusColor

    // Visual configuration
    property color titleColor: theme.textPrimary
    property color accentColor: theme.heartRateColor

    property int titleSize: theme.fontMedium
    property int valueSize: theme.fontVital
    property int compactValueSize: theme.fontVitalCompact

    // Layout configuration
    property int cardSpacing: theme.spacingMedium
    property int heartPreferredWidth: 190
    property int heartMinimumWidth: 150
    property int minimumContentHeight: 110

    readonly property bool compactMode: contentArea.height < 155

    preferredWidth: 500
    preferredHeight: 210

    contentPadding: theme.cardPadding

    clip: true

    VitalStatus {
        id: heartRateStatus

        hasData: root.hasData
        value: root.heartRate

        minimumCritical: 40
        minimumNormal: 60
        maximumNormal: 100
        maximumCritical: 140
    }

    RowLayout {
        id: contentArea
        anchors.fill: parent
        spacing: root.cardSpacing

        // Clinical information
        Item {
            id: informationArea

            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.minimumWidth: 130
            Layout.minimumHeight: 0

            PulseLabel {
                id: heartRateTitle

                anchors.top: parent.top
                anchors.left: parent.left

                text: "HEART RATE"
                labelColor: root.titleColor
                labelSize: root.titleSize
                fontFamily: theme.fontFamily

                emphasized: true
            }

            PulseNumber {
                id: heartRateValue
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                value: root.heartRate
                hasData: root.hasData
                unit: "bpm"

                valueSize: root.compactMode
                           ? root.compactValueSize : root.valueSize

                valueColor: root.statusColor
                unitColor: theme.textSecondary
                fontFamily: theme.fontFamily
            }

            PulseBadge {
                id: heartRateBadge
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                status: root.status
            }
        }

        // Anatomical heart visualization
        Heart3D {
            id: heart3D

            Layout.preferredWidth: root.heartPreferredWidth
            Layout.minimumWidth: root.heartMinimumWidth
            Layout.maximumWidth: root.heartPreferredWidth

            Layout.fillHeight: true
            Layout.minimumHeight: 0

            Layout.alignment: Qt.AlignVCenter

            running: root.running
            heartRate: root.heartRate
        }
    }

    function triggerHeartbeat() {
        heart3D.triggerHeartbeat()
    }

    function resetHeartbeat() {
        heart3D.resetHeartbeat()
    }
}
