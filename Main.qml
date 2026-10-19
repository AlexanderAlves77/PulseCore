import QtQuick

import "Components/Layout"

Window {
    id: window    
    width: 1280
    height: 800
    minimumWidth: 1024
    minimumHeight: 640
    visible: true
    title: "PulseCore - Medical Device Monitoring Simulator"
    color: "#0B111B"

    readonly property string simulationState: simulationController.state

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
        AppHeader {
            id: header
            height: 90
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            surfaceColor: window.surfaceColor
            titleColor: window.textColor
            accentColor: window.primaryColor
        }

        AppFooter {
            id: footer
            height: 60
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            surfaceColor: window.surfaceColor
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

                // Dashboard layout
                Column {
                    id: dashboardLayout
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    // ECG and 3D heart
                    Row {
                        id: visualizationRow
                        width: parent.width
                        height: Math.max(120,
                            dashboardLayout.height - vitalSignsRow.height
                            - simulationControls.height - dashboardLayout.spacing * 2
                        )
                        spacing: 16

                        EcgWaveform {
                            id: ecgMonitor
                            width: (visualizationRow.width - visualizationRow.spacing) * 0.60
                            height: visualizationRow.height
                            running: window.simulationState === "RUNNING"
                        }

                        Heart3D {
                            id: heartMonitor
                            width: (visualizationRow.width - visualizationRow.spacing) * 0.40
                            height: visualizationRow.height
                            running: window.simulationState === "RUNNING"
                            heartRate: simulationController.heartRate
                        }
                    }

                    // Monitoring area
                    Row {
                        id: vitalSignsRow
                        width: parent.width
                        height: 145
                        spacing: 16

                        VitalCard {
                            width: (vitalSignsRow.width - vitalSignsRow.spacing * 3) / 4
                            height: vitalSignsRow.height
                            label: "HR"
                            value: simulationController.heartRate.toString()
                            unit: "bpm"
                            accentColor: "#40DCA5"
                        }

                        VitalCard {
                            width: (vitalSignsRow.width - vitalSignsRow.spacing * 3) / 4
                            height: vitalSignsRow.height
                            label: "SpO₂"
                            value: simulationController.oxygenSaturation.toString()
                            unit: "%"
                            accentColor: "#61B8FA"
                        }

                        VitalCard {
                            width: (vitalSignsRow.width - vitalSignsRow.spacing * 3) / 4
                            height: vitalSignsRow.height
                            label: "RESP"
                            value: simulationController.respiratoryRate.toString()
                            unit: "rpm"
                            accentColor: "#F0B75E"
                        }

                        VitalCard {
                            width: (vitalSignsRow.width - vitalSignsRow.spacing * 3) / 4
                            height: vitalSignsRow.height
                            label: "TEMP"
                            value: simulationController.temperature.toFixed(1)
                            unit: "°C"
                            accentColor: "#E9A6F4"
                        }
                    }

                    // Controls
                    SimulationControls {
                        id: simulationControls
                        width: parent.width
                        height: 76

                        simulationState: window.simulationState

                        onStartRequested: {
                            simulationController.Start();
                        }

                        onPauseRequested: {
                            simulationController.Pause();
                        }

                        onResetRequested: {
                            simulationController.Reset();
                            ecgMonitor.animationOffset = 0;
                        }
                    }
                }
            }
        }
    }
}
