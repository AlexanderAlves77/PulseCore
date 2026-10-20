import QtQuick

Item {
    id: root

    property string iconName: "settings"

    property color iconColor: "#00DDF2"
    property color hoverColor: "#102D37"
    property color pressedColor: "#16435A"
    property color borderColor: "#16435A"
    property color backgroundColor: "#0B1621"

    property int buttonSize: 40
    property int iconSize: 24
    property int cornerRadius: 8
    property int borderThickness: 1

    property bool outlined: true

    signal clicked()

    implicitWidth: buttonSize
    implicitHeight: buttonSize

    opacity: enabled ? 1.0 : 0.4

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