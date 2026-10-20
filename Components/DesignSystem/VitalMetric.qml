import QtQuick

Item {
    id: root

    PulseTheme {
        id: theme
    }

    // Vital sign data
    property string title: "Heart Rate"
    property real value: 0
    property string unit: "bpm"

    property bool hasData: false
    property int decimals: 0

    // Typography
    property int titleSize: 14
    property int numberSize: 56

    // Layout
    property int contentSpacing: theme.spacingSmall
    property int preferredMetricWidth: 240

    // Classification thresholds
    property real minimumCritical: 40
    property real minimumNormal: 60
    property real maximumNormal: 100
    property real maximumCritical: 140

    // Derived state
    readonly property string status: vitalStatus.status
    readonly property color statusColor: vitalStatus.statusColor

    implicitWidth: root.preferredMetricWidth
    implicitHeight: metricLayout.implicitHeight

    VitalStatus {
        id: vitalStatus
        hasData: root.hasData
        value: root.value
        minimumCritical: root.minimumCritical
        minimumNormal: root.minimumNormal
        maximumNormal: root.maximumNormal
        maximumCritical: root.maximumCritical
    }

    Column {
        id: metricLayout
        width: parent.width
        spacing: root.contentSpacing

        PulseLabel {
            text: root.title
            labelColor: theme.textPrimary
            labelSize: root.titleSize
        }

        PulseNumber {
            value: root.value
            decimals: root.decimals
            unit: root.unit
            hasData: root.hasData
            valueSize: root.numberSize
            valueColor: root.statusColor
            unitColor: theme.textSecondary
        }

        PulseBadge {
            status: root.status
        }
    }
}
