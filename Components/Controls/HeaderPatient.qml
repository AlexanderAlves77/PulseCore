import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

RowLayout {
    id: root

    PulseTheme {
        id: theme
    }

    // Patient information
    property string title: theme.patientTitle
    property string patientName: theme.defaultPatientName
    property string patientType: theme.defaultPatientType

    // Icon configuration
    property string iconName: theme.patientIconName
    property color iconColor: theme.cyan
    property int iconSize: 26

    // Typography
    property string fontFamily: theme.fontFamily

    property int titleSize: theme.fontLabel
    property int valueSize: 14

    // Colors
    property color titleColor: theme.textSecondary
    property color valueColor: theme.textPrimary
    property color typeColor: theme.textSecondary

    // Layout
    property string separator: " · "
    property int contentSpacing: theme.spacingCard
    property int textSpacing: theme.spacingTiny

    spacing: root.contentSpacing

    PulseIcon {
        id: patientIcon

        iconName: root.iconName
        iconColor: root.iconColor
        iconSize: root.iconSize

        Layout.alignment: Qt.AlignVCenter
    }

    ColumnLayout {
        id: patientContent

        spacing: root.textSpacing

        PulseLabel {
            id: patientTitle

            text: root.title

            labelColor: root.titleColor
            labelSize: root.titleSize
            fontFamily: root.fontFamily
        }

        RowLayout {
            id: patientDetails

            spacing: 0

            PulseLabel {
                id: patientNameLabel

                text: root.patientName

                labelColor: root.valueColor
                labelSize: root.valueSize
                fontFamily: root.fontFamily

                emphasized: true
            }

            PulseLabel {
                id: patientTypeLabel

                text: root.separator + root.patientType

                labelColor: root.typeColor
                labelSize: root.valueSize
                fontFamily: root.fontFamily

                visible: root.patientType.length > 0
            }
        }
    }
}
