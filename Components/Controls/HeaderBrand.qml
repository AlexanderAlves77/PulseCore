import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

RowLayout {
    id: root

    PulseTheme {
        id: theme
    }

    // Brand identity
    property string primaryName: "Pulse"
    property string accentName: "Core"
    property string iconName: "ecg"
    property string description: "MEDICAL DEVICE MONITORING SIMULATOR"

    // Typography
    property string fontFamily: theme.fontFamily

    property int titleSize: 24
    property int descriptionSize: theme.fontCaption

    // Colors
    property color primaryColor: theme.textPrimary
    property color accentColor: theme.cyan
    property color descriptionColor: theme.textSecondary

    // Icon
    property int iconSize: 40

    // Layout
    property int contentSpacing: theme.paddingMedium
    property int textSpacing: 2

    spacing: root.contentSpacing

    PulseIcon {
        id: brandIcon
        iconName: root.iconName
        iconColor: root.accentColor
        iconSize: root.iconSize
        Layout.alignment: Qt.AlignVCenter
    }

    ColumnLayout {
        id: brandContent
        spacing: root.textSpacing

        RowLayout {
            id: brandTitle
            spacing: 0

            PulseLabel {
                text: root.primaryName
                labelColor: root.primaryColor
                labelSize: root.titleSize
                fontFamily: root.fontFamily
                emphasized: true
            }

            PulseLabel {
                text: root.accentName
                labelColor: root.accentColor
                labelSize: root.titleSize
                fontFamily: root.fontFamily
                emphasized: true
            }
        }

        PulseLabel {
            text: root.description
            labelColor: root.descriptionColor
            labelSize: root.descriptionSize
            fontFamily: root.fontFamily
            Layout.fillWidth: true
        }
    }
}
