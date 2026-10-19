import QtQuick

Item {
    id: root

    property string title: "Heart Rate"
    property real value: 0
    property string unit: "bpm"

    property int decimals: 0
    property int numberSize: 56

    property real minimumCritical: 40
    property real minimumNormal: 60
    property real maximumNormal: 100
    property real maximumCritical: 140

    readonly property string status: vitalStatus.status
    readonly property color statusColor: vitalStatus.statusColor

    implicitWidth: 240
    implicitHeight: metricLayout.implicitHeight

    VitalStatus {
        id: vitalStatus

        value: root.value
        minimumCritical: root.minimumCritical
        minimumNormal: root.minimumNormal
        maximumNormal: root.maximumNormal
        maximumCritical: root.maximumCritical
    }

    Column {
        id: metricLayout

        width: parent.width
        spacing: 8

        PulseLabel {
            text: root.title
            labelSize: 14
        }

        PulseNumber {
            value: root.value
            decimals: root.decimals
            unit: root.unit
            valueSize: root.numberSize
            valueColor: root.statusColor
        }

        PulseBadge {
            status: root.status
        }
    }
}