import QtQuick

Rectangle {
    id: root

    PulseTheme {
        id: theme
    }

    // Data
    property string status: "NORMAL"

    // Typography
    property string fontFamily: theme.fontFamily
    property int textSize: theme.fontLabel

    // Status colors
    property color normalColor: theme.normal
    property color warningColor: theme.warning
    property color criticalColor: theme.critical
    property color runningColor: theme.cyan
    property color pausedColor: theme.paused
    property color defaultColor: theme.textSecondary

    // Appearance
    property color backgroundColor: theme.background

    property int badgeHeight: theme.badgeHeight
    property int horizontalPadding: theme.badgeHorizontalPadding
    property int borderThickness: theme.borderThin
    property int cornerRadius: theme.badgeRadius

    // Behavior
    property bool emphasized: true
    property bool outlined: true

    readonly property string normalizedStatus: status.trim().toUpperCase()

    readonly property color statusColor:
    {
        switch (normalizedStatus)
        {
        case "NORMAL":
            return normalColor

        case "warningColor":
            return normalColor

        case "CRITICAL":
            return criticalColor

        case "RUNNING":
            return runningColor

        case "PAUSED":
            return pausedColor

        default:
            return defaultColor
        }
    }

    implicitWidth: statusLabel.implicitWidth + root.horizontalPadding * 2
    implicitHeight: root.badgeHeight

    radius: root.cornerRadius
    color: root.backgroundColor

    border.color: root.statusColor
    border.width: root.outlined ? root.borderThickness : 0

    PulseLabel {
        id: statusLabel

        anchors.centerIn: parent

        text: root.normalizedStatus
        labelColor: root.statusColor
        labelSize: root.textSize
        fontFamily: root.fontFamily
        emphasized: root.emphasized
    }
}