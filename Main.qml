import QtQuick


Window {
    id: window    
    width: 1280
    height: 800
    minimumWidth: 1024
    minimumHeight: 640
    visible: true
    title: "PulseCore - Medical Device Monitoring Simulator"
    color: "#0B111B"

    // Application colors
    readonly property color backgroundColor: "#0B111B"
    readonly property color surfaceColor: "#141F2E"
    readonly property color borderColor: "#263548"
    readonly property color primaryColor: "#40DCA5"
    readonly property color textColor: "#F2F6FC"
    readonly property color mutedTextColor: "#91A3B8"

    // Main container
    Rectangle {
        id: mainContainer
        anchors.fill: parent
        color: window.backgroundColor

        // Header
        Rectangle {
            id: header
            height: 90
            color: window.surfaceColor
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            // Application name
            Text {
                id: applicationTitle
                text: "PULSECORE"
                color: window.textColor
                font.pixelSize: 28
                font.bold: true
                anchors.left: parent.left
                anchors.leftMargin: 32
                anchors.verticalCenter: parent.verticalCenter
            }

            // Simulation indicator
            Rectangle {
                id: simulationIndicator
                width: 160
                height: 36
                radius: 8
                color: "#273C35"
                anchors.right: parent.right
                anchors.rightMargin: 32
                anchors.verticalCenter: parent.verticalCenter


                // Application name
                Text {
                    text: "SIMULATION"
                    color: window.primaryColor
                    font.pixelSize: 13
                    font.bold: true
                    anchors.centerIn: parent
                }
            }
        }

        // Main content area
        Rectangle {
            id: contentArea
            color: window.backgroundColor
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 24

            // Header
            Rectangle {
                id: monitorPanel
                color: window.surfaceColor
                anchors.fill: parent
                border.color: window.borderColor
                border.width: 1
                radius: 12

                // Application name
                Text {
                    text: "MONITORING DASHBOARD"
                    color: window.mutedTextColor
                    font.pixelSize: 18
                    font.bold: true
                    anchors.centerIn: parent
                }
            }
        }

        // Footer
        Rectangle {
            id: footer
            height: 60
            color: window.surfaceColor
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            Text {
                text: "SIMULATION ONLY — NOT FOR CLINICAL USE"
                color: "#F0B75E"
                font.pixelSize: 13
                font.bold: true
                anchors.centerIn: parent
            }
        }
    }
}
