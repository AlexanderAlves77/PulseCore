import QtQuick
import QtQuick.Layouts

import "Components/DesignSystem"
import "Components/Layout"
import "Components/Monitoring"

Window {
    id: window    
    width: 1280
    height: 800
    minimumWidth: 1024
    minimumHeight: 700
    visible: true
    title: "PulseCore - Medical Device Monitoring Simulator"

    property bool hasSimulationData: false

    PulseTheme {
        id: pulseTheme
    }

    color: pulseTheme.background

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
            spacing: 12

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                spacing: 12

                LeftMonitoringPanel {
                    id: leftMonitoringPanel

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 62
                }

                RightMonitoringPanel {
                    id: rightMonitoringPanel
                    hasData: window.hasSimulationData

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 38

                    heartRate: simulationController.heartRate
                    oxygenSaturation: simulationController.oxygenSaturation
                    respiratoryRate: simulationController.respiratoryRate
                    temperature: simulationController.temperature

                    running: window.simulationState === "RUNNING"
                }
            }

            // Controls
            SimulationControls {
                id: simulationControls
                Layout.fillWidth: true
                Layout.preferredHeight: 76
                simulationState: window.simulationState

                onStartRequested: {
                    simulationController.Start()
                }

                onPauseRequested: {
                    simulationController.Pause()
                }

                onResetRequested: {
                    simulationController.Reset()
                    window.hasSimulationData = false
                    monitoringPanel.clearEcgSamples()
                    monitoringPanel.resetHeartbeat()
                }
            }
        }
    }

    Connections {
        target: simulationController

        function onEcgSampleGenerated(sample) {
            window.hasSimulationData = true
            leftMonitoringPanel.addEcgSample(sample)
        }

        function onHeartbeatOccurred() {
            monitoringPanel.triggerHeartbeat()
        }
    }
}
