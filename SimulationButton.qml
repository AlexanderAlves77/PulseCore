import QtQuick

Rectangle {
    id: simulationButton
    radius: 8

    property string label: ""
    property color textColor: "#FFFFFF"
    property color backgroundColor: "#273C35"
    property color hoverColor: "#35B98C"

    signal clicked();

    implicitWidth: 100
    implicitHeight: 40

    color: mouseArea.containsMouse ? hoverColor : backgroundColor

    Text {
        anchors.centerIn: parent
        text: simulationButton.label
        color: simulationButton.textColor
        font.pixelSize: 14
        font.bold: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: simulationButton.clicked()
    }
}
