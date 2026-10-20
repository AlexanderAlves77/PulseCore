import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

PulseCard {
    id: root

    property string title: ""
    property string unit: ""

    property color accentColor: "#21F58B"

    property int decimals: 0

    property real value: 0
    property real minimumCritical: 40
    property real minimumNormal: 60
    property real maximumNormal: 100
    property real maximumCritical: 140

    property bool hasData: false

    readonly property string status: vitalStatus.status

    readonly property color displayColor:
    {
        if (!root.hasData)
            return "#648398"

        if (root.status === "NORMAL")
            return root.accentColor

        return vitalStatus.statusColor
    }

    preferredWidth: 220
    preferredHeight: 89
    contentPadding: 12

    VitalStatus {
        id: vitalStatus

        hasData: root.hasData
        value: root.value

        minimumCritical: root.minimumCritical
        minimumNormal: root.minimumNormal
        maximumNormal: root.maximumNormal
        maximumCritical: root.maximumCritical
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 4

        PulseLabel {
            text: root.title
            labelSize: 13
            emphasized: true
            labelColor: root.displayColor
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            PulseNumber {
                visible: root.hasData

                value: root.value
                decimals: root.decimals
                unit: root.unit

                valueSize: 38
                unitSize: 12
                valueColor: root.displayColor
                hasData: root.hasData
            }

            PulseLabel {
                visible: !root.hasData
                text: "--"
                labelSize: 38
                labelColor: "#648398"
            }
        }
    }
}