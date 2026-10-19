import QtQuick

Rectangle {
    id: root

    property string status: "NORMAL"

    readonly property color statusColor: {
        switch (status.toUpperCase()) {
        case "WARNING":
            return "#FFB020"
        case "CRITICAL":
            return "#FF405D"
        default:
            return "#21F58B"
        }
    }

    implicitWidth: badgeText.implicitWidth + 28
    implicitHeight: 30

    radius: height / 2
    color: Qt.rgba(
        statusColor.r,
        statusColor.g,
        statusColor.b,
        0.15
    )

    border.color: statusColor
    border.width: 1

    Text {
        id: badgeText

        anchors.centerIn: parent

        text: root.status.toUpperCase()
        color: root.statusColor

        font.family: "Segoe UI"
        font.pixelSize: 12
        font.bold: true
    }
}