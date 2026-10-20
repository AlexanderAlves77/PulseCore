import QtQuick

Rectangle {
    id: root

    property color cardColor: "#0B1621"
    property color borderColor: "#16435A"

    property int borderThickness: 1
    property int cornerRadius: 14
    property int contentPadding: 16

    property int preferredWidth: 320
    property int preferredHeight: 136

    property bool outlined: true

    default property alias content: contentContainer.data

    implicitWidth: preferredWidth
    implicitHeight: preferredHeight

    radius: cornerRadius
    color: cardColor

    border.color: borderColor
    border.width: outlined ? borderThickness : 0

    Item {
        id: contentContainer

        anchors.fill: parent
        anchors.margins: root.contentPadding
    }
}