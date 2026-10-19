
import QtQuick

Rectangle {
    id: root
    implicitHeight: 60
    color: root.surfaceColor

    property color surfaceColor: "#141F2E"
    property color warningColor: "#F0B75E"
    property string disclaimerText: "SIMULATION ONLY — NOT FOR CLINICAL USE"

    Text {
        id: disclaimerLabel
        anchors.centerIn: parent
        text: root.disclaimerText
        color: root.warningColor
        font.pixelSize: 13
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
