import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

PulseCard {
    id: root

    property string title: ""
    property real value: 0
    property string unit: ""
    property int decimals: 0

    property bool hasData: false

    property real minimumCritical: 40
    property real minimumNormal: 60
    property real maximumNormal: 100
    property real maximumCritical: 140

    property color accentColor: "#21F58B"

    readonly property string status: vitalStatus.status
    readonly property color displayColor: {
        if (!hasData)
            return "#648398"

        if (status === "NORMAL")
            return accentColor

        return vitalStatus.statusColor
    }

    cardSize: "SMALL"

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