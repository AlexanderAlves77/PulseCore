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

        SimulationButton {
            label: "Start"
            textColor: "#40DCA5"
            backgroundColor: "#273C35"
            hoverColor: "#35B98C"

            onClicked: simulationControls.startRequested()
        }

        SimulationButton {
            label: "Pause"
            textColor: "#F0B75E"
            backgroundColor: "#302B24"
            hoverColor: "#51432D"

            onClicked: simulationControls.pauseRequested()
        }

        SimulationButton {
            label: "Reset"
            textColor: "#F08A9B"
            backgroundColor: "#30242A"
            hoverColor: "#51333A"

            onClicked: simulationControls.resetRequested()
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

    signal onStartRequested()

    signal onPauseRequested()

    signal onResetRequested()
}
