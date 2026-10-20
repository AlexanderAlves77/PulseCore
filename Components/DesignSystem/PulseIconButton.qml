import QtQuick

Item {
    id: root

    PulseTheme {
        id: theme
    }

    // Icon
    property string iconName: "settings"

    // Appearance
    property color iconColor: theme.cyan
    property color hoverColor: theme.surfaceHover
    property color pressedColor: theme.surfacePressed
    property color borderColor: theme.border
    property color backgroundColor: theme.surface

    // Dimensions
    property int buttonSize: 40
    property int iconSize: theme.iconMedium
    property int cornerRadius: theme.radiusMedium
    property int borderThickness: theme.borderThin

    // Behavior
    property bool outlined: true

    signal clicked()

    implicitWidth: root.buttonSize
    implicitHeight: root.buttonSize

    opacity: root.enabled ? 1.0 : 0.4

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        radius: root.cornerRadius

        color: mouseArea.pressed ? root.pressedColor : mouseArea.containsMouse
            ? root.hoverColor : root.backgroundColor

        border.width: root.outlined ? root.borderThickness : 0
        border.color: root.borderColor
    }

    PulseIcon {
        id: buttonIcon
        anchors.centerIn: parent
        iconName: root.iconName
        iconColor: root.iconColor
        iconSize: root.iconSize
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
        cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: root.clicked()
    }
}