import QtQuick

Rectangle {
    id: simulationControls
    radius: 12
    color: "#101A27"

    property string simulationState: "RUNNING"

    signal startRequested();
    signal pauseRequested();
    signal resetRequested();

    implicitWidth: 560
    implicitHeight: 76

    border.color: "#263548"
    border.width: 1

    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 20

        spacing: 12

        Rectangle {
            width: 100
            height: 40
            radius: 8

            color: startMouseArea.containsMouse ? "#35B98C" : "#273C35"

            Text {
                anchors.centerIn: parent
                text: "Start"
                color: "#40DCA5"
                font.pixelSize: 14
                font.bold: true
            }

            MouseArea {
                id: startMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: simulationControls.startRequested()
            }
        }

        Rectangle {
            width: 100
            height: 40
            radius: 8

            color: pauseMouseArea.containsMouse ? "#51432D" : "#302B24"

            Text {
                anchors.centerIn: parent
                text: "Pause"
                color: "#F0B75E"
                font.pixelSize: 14
                font.bold: true
            }

            MouseArea {
                id: pauseMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: simulationControls.pauseRequested()
            }
        }

        Rectangle {
            width: 100
            height: 40
            radius: 8

            color: resetMouseArea.containsMouse ? "#51333A" : "#30242A"

            Text {
                anchors.centerIn: parent
                text: "Reset"
                color: "#F08A9B"
                font.pixelSize: 14
                font.bold: true
            }

            MouseArea {
                id: resetMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: simulationControls.resetRequested()
            }
        }
    }

    Text {
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        text: simulationControls.simulationState
        color: simulationControls.simulationState === "RUNNING" ? "#40DCA5"
            : simulationControls.simulationState === "PAUSED" ? "#F0B75E" : "#F08A9B"
        font.pixelSize: 13
        font.bold: true
    }
}
