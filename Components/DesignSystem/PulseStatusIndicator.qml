import QtQuick

Row {
    id: root

    property string status: "STOPPED"

    readonly property color indicatorColor: {
        switch (status.toUpperCase()) {
        case "RUNNING":
            return "#21F58B"
        case "PAUSED":
            return "#FFB020"
        default:
            return "#648398"
        }
    }

    spacing: 8

    Rectangle {
        width: 9
        height: 9
        radius: width / 2

        anchors.verticalCenter: parent.verticalCenter

        color: root.indicatorColor

        SequentialAnimation on opacity {
            running: root.status === "RUNNING"
            loops: Animation.Infinite

            NumberAnimation {
                to: 0.35
                duration: 650
            }

            NumberAnimation {
                to: 1.0
                duration: 650
            }
        }
    }

    PulseLabel {
        text: root.status
        labelColor: root.indicatorColor
        labelSize: 12
        emphasized: true
    }
}
