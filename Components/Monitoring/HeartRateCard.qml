import QtQuick
import QtQuick.Layouts

import "../DesignSystem"
import PulseCore

PulseCard {
    id: root

    property int heartRate: 0
    property bool running: false
    property bool hasData: false

    readonly property string status: heartRateStatus.status
    readonly property color statusColor: heartRateStatus.statusColor

    cardSize: "LARGE"

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
        anchors.fill: parent
        spacing: 12

        ColumnLayout {
            Layout.fillWidth: true
            Layout.minimumWidth: 130
            Layout.alignment: Qt.AlignVCenter
            spacing: 12

            PulseLabel {
                text: "HEART RATE"
                labelSize: 15
                emphasized: true
            }

            PulseNumber {
                value: root.heartRate
                unit: "bpm"
                valueSize: 72
                valueColor: root.statusColor
            }

            PulseBadge {
                status: root.status
            }
        }

        Heart3D {
            id: heart3D

            Layout.preferredWidth: 190
            Layout.preferredHeight: 170

            Layout.maximumWidth: 190
            Layout.maximumHeight: 170

            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

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