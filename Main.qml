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

    property string simulationState: "RUNNING"

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
                text: "PULSECORE"
                color: window.textColor
                font.pixelSize: 28
                font.bold: true
                anchors.left: parent.left
                anchors.leftMargin: 32
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                width: 160
                height: 36
                radius: 8
                color: "#273C35"
                anchors.right: parent.right
                anchors.rightMargin: 32
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    text: "SIMULATION"
                    color: window.primaryColor
                    font.pixelSize: 13
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

        // Main content
        Rectangle {
            id: contentArea
            color: window.backgroundColor
            anchors.top: header.bottom
            anchors.bottom: footer.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 24

            Rectangle {
                id: monitorPanel
                color: window.surfaceColor
                anchors.fill: parent
                border.color: window.borderColor
                border.width: 1
                radius: 12

                // Controls
                SimulationControls {
                    id: simulationControls
                    height: 76
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 20

                    simulationState: window.simulationState

                    onStartRequested: {
                        window.simulationState = "RUNNING";
                    }

                    onPauseRequested: {
                        window.simulationState = "PAUSED";
                    }

                    onResetRequested: {
                        window.simulationState = "STOPPED";
                        ecgMonitor.animationOffset = 0;
                    }
                }

                // Monitoring area
                Row {
                    id: monitoringLayout
                    anchors.top: parent.top
                    anchors.bottom: simulationControls.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 20
                    spacing: 20

                    EcgWaveform {
                        id: ecgMonitor
                        width: monitoringLayout.width
                               - vitalSignsGrid.width - monitoringLayout.spacing
                        height: monitoringLayout.height
                        running: window.simulationState === "RUNNING"
                    }

                    Grid {
                        id: vitalSignsGrid
                        columns: 2
                        spacing: 16
                        anchors.verticalCenter: parent.verticalCenter

                        VitalCard {
                            width: 180
                            height: 145
                            label: "HR"
                            value: "78"
                            unit: "bpm"
                            accentColor: "#40DCA5"
                        }

                        VitalCard {
                            width: 180
                            height: 145
                            label: "SpO₂"
                            value: "98"
                            unit: "%"
                            accentColor: "#61B8FA"
                        }

                        VitalCard {
                            width: 180
                            height: 145
                            label: "RESP"
                            value: "16"
                            unit: "rpm"
                            accentColor: "#F0B75E"
                        }

                        VitalCard {
                            width: 180
                            height: 145
                            label: "TEMP"
                            value: "36.7"
                            unit: "°C"
                            accentColor: "#E9A6F4"
                        }
                    }
                }
            }
        }
    }

    Heart3D {
        anchors.fill: parent
        anchors.margins: 20
        running: window.simulationState === "RUNNING"
        heartRate: 78
    }
}
