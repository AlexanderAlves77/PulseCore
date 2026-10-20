import QtQuick

Rectangle {
    id: root

    property string status: "NORMAL"
    property string fontFamily: "Segoe UI"

    property color normalColor: "#21F58B"
    property color warningColor: "#FFB020"
    property color criticalColor: "#FF405D"
    property color runningColor: "#00DDF2"
    property color pausedColor: "#FFE34A"
    property color defaultColor: "#9AB6C8"
    property color backgroundColor: "#02070C"

    property int badgeHeight: 28
    property int horizontalPadding: 12
    property int borderThickness: 1
    property int cornerRadius: 6
    property int textSize: 11

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

    implicitWidth: statusLabel.implicitWidth + horizontalPadding * 2
    implicitHeight: badgeHeight

    radius: cornerRadius
    color: backgroundColor

    border.color: statusColor
    border.width: outlined ? borderThickness : 0

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