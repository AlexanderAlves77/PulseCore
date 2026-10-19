
import QtQuick

Rectangle {
    id: root
    height: 90
    color: root.surfaceColor

    property color surfaceColor: "#141F2E"
    property color titleColor: "#F2F6FC"
    property color accentColor: "#40DCA5"

    property string applicationName: "PULSECORE"
    property string simulationLabel: "SIMULATION"

    Text {
        id: applicationTitle
        text: root.applicationName
        color: root.titleColor
        font.pixelSize: 28
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 32
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle {
        id: simulationBadge
        width: 160
        height: 36
        radius: 8
        color: "#273C35"
        anchors.right: parent.right
        anchors.rightMargin: 32
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: root.simulationLabel
            color: root.accentColor
            font.pixelSize: 13
            font.bold: true
            anchors.centerIn: parent
        }
    }
}
