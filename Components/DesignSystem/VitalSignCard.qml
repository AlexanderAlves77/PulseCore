import QtQuick
import QtQuick.Layouts

PulseCard {
    id: root

    PulseTheme {
        id: theme
    }

    // Vital sign data
    property string title: "Heart Rate"
    property real value: 78
    property string unit: "bpm"
    property string status: "NORMAL"

    // Data availability
    property bool hasData: true
    property int decimals: 0

    // Appearance
    property color accentColor: theme.heartRateColor
    property color titleColor: theme.textSecondary

    // Typography
    property int titleSize: theme.fontMedium
    property int valueSize: 56

    // Layout
    property int contentSpacing: theme.spacingSmall
    property int metricSpacing: theme.spacingMedium

    // Card dimensions
    preferredHeight: theme.cardMediumHeight

    ColumnLayout {
        anchors.fill: parent
        spacing: root.contentSpacing

        PulseLabel {
            id: titleLabel
            text: root.title
            labelColor: root.titleColor
            labelSize: root.titleSize
            Layout.fillWidth: true
        }

        RowLayout {
            id: metricLayout
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: root.metricSpacing

            PulseNumber {
                id: vitalNumber

                value: root.value
                decimals: root.decimals
                unit: root.unit
                hasData: root.hasData

                valueColor: root.accentColor
                valueSize: root.valueSize

                Layout.alignment: Qt.AlignVCenter
            }

            Item {
                Layout.fillWidth: true
            }

            PulseBadge {
                id: statusBadge
                status: root.hasData ? root.status : "NO DATA"
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
}
