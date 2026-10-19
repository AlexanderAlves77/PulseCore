import QtQuick

import "Components/Layout"
import "Components/Monitoring"

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
        DashboardPanel {
            id: dashboardPanel
            anchors.top: header.bottom
            anchors.bottom: footer.top
            anchors.left: parent.left
            anchors.right: parent.right
            backgroundColor: window.backgroundColor
            surfaceColor: window.surfaceColor
            borderColor: window.borderColor

            Column {
                id: dashboardLayout
                anchors.fill: parent
                spacing: 16

                // ECG and 3D heart
                MonitoringPanel {
                    id: monitoringPanel
                    width: parent.width

                    height: Math.max(
                        120,
                        dashboardLayout.height
                        - vitalSignsPanel.height
                        - simulationControls.height
                        - dashboardLayout.spacing * 2
                    )

                    running: window.simulationState === "RUNNING"
                    heartRate: simulationController.heartRate
                }

                // Monitoring area
                VitalSignsPanel {
                    id: vitalSignsPanel
                    width: parent.width
                    height: 145
                    heartRate: simulationController.heartRate
                    oxygenSaturation: simulationController.oxygenSaturation
                    respiratoryRate: simulationController.respiratoryRate
                    temperature: simulationController.temperature
                }

                // Controls
                SimulationControls {
                    id: simulationControls
                    width: parent.width
                    height: 76
                    simulationState: window.simulationState

                    onStartRequested: {
                        simulationController.Start()
                    }

                    onPauseRequested: {
                        simulationController.Pause()
                    }

                    onResetRequested: {
                        simulationController.Reset()
                        monitoringPanel.clearEcgSamples()
                        monitoringPanel.resetHeartbeat()
                    }
                }
            }
        }
    }

    Connections {
        target: simulationController

        function onEcgSampleGenerated(sample) {
            monitoringPanel.addEcgSample(sample)
        }

        function onHeartbeatOccurred() {
            monitoringPanel.triggerHeartbeat()
        }
    }
}
