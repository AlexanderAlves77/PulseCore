import QtQuick

Rectangle {
    id: root

    property string cardSize: "MEDIUM"

    property color surfaceColor: "#0B1621"
    property color outlineColor: "#16435A"

    default property alias content: contentContainer.data

    implicitWidth: 320

    implicitHeight: {
        switch (cardSize.toUpperCase()) {
        case "SMALL":
            return 96
        case "LARGE":
            return 300
        default:
            return 136
        }
    }

    radius: 14
    color: surfaceColor

    border.color: outlineColor
    border.width: 1

    Item {
        id: contentContainer

        anchors.fill: parent
        anchors.margins: 16
    }
}