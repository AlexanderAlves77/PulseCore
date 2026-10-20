import QtQuick

Item {
    id: root

    property string iconName: "settings"
    property color iconColor: "#9AB6C8"
    property color hoverColor: "#00DDF2"
    property color backgroundColor: "transparent"

    signal clicked()

    implicitWidth: 36
    implicitHeight: 36

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        radius: 8

        color: mouseArea.containsMouse
            ? "#10202B"
            : root.backgroundColor

        border.width: mouseArea.containsMouse ? 1 : 0
        border.color: "#16435A"
    }

    PulseIcon {
        anchors.centerIn: parent
        width: 26
        height: 26
        iconName: root.iconName

        iconColor: mouseArea.containsMouse
            ? root.hoverColor
            : root.iconColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}