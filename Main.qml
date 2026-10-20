import QtQuick
import QtQuick.Layouts

import "Components/DesignSystem"
import "Components/Layout"
import "Components/Monitoring"

Window {
    id: window    
    width: 1280
    height: 800
    minimumWidth: 1100
    minimumHeight: 700
    visible: true
    title: "PulseCore - Medical Device Monitoring Simulator"

    property bool hasSimulationData: false
    readonly property string simulationState: simulationController.state
    property int simulationElapsedSeconds: 0

    readonly property string formattedSimulationTime: {
        const hours = Math.floor(simulationElapsedSeconds / 3600)
        const minutes = Math.floor((simulationElapsedSeconds % 3600) / 60)
        const seconds = simulationElapsedSeconds % 60

        return String(hours).padStart(2, "0") + ":"
             + String(minutes).padStart(2, "0") + ":"
             + String(seconds).padStart(2, "0")
    }

    PulseTheme {
        id: pulseTheme
    }

    color: pulseTheme.background

    Timer {
        interval: 1000
        repeat: true
        running: window.simulationState === "RUNNING"

        onTriggered: {
            window.simulationElapsedSeconds++
        }
    }

    // Header
    AppHeader {
        id: header
        height: 64
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        patientName: "Adult"
        scenarioName: "Normal"
        simulationTime: window.formattedSimulationTime
        batteryLevel: 100

        surfaceColor: "#07121D"
        titleColor: "#F2F7FC"
        accentColor: "#21F58B"

        onScenarioRequested: {
            console.log("Scenario selection is not implemented yet")
        }

        onSettingsRequested: {
            console.log("Settings panel is not implemented yet")
        }
    }

    AppFooter {
        id: footer
        height: 30
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        surfaceColor: "#0B1621"
     /*   surfaceColor: pulseTheme.surfaceColor */
    }

    // Main content
    DashboardPanel {
        id: dashboardPanel
        anchors.fill: parent

        anchors.topMargin: header.height + 2
        anchors.bottomMargin: footer.height + 2
        anchors.leftMargin: 2
        anchors.rightMargin: 2

        backgroundColor: "#050B12"
        surfaceColor: "#0B1621"
        borderColor: "#16435A"
        /*
        backgroundColor: pulseTheme.backgroundColor
        surfaceColor: pulseTheme.surfaceColor
        borderColor: pulseTheme.borderColor */

        ColumnLayout {
            id: dashboardLayout
            anchors.fill: parent
            spacing: 5

            RowLayout {
                id: monitoringLayout

                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 10

                LeftMonitoringPanel {
                    id: leftMonitoringPanel

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 62
                    Layout.minimumWidth: 350
                }

                RightMonitoringPanel {
                    id: rightMonitoringPanel

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 38
                    Layout.minimumWidth: 280

                    heartRate: simulationController.heartRate
                    oxygenSaturation: simulationController.oxygenSaturation
                    respiratoryRate: simulationController.respiratoryRate
                    temperature: simulationController.temperature

                    running: window.simulationState === "RUNNING"
                    hasData: window.hasSimulationData
                }
            }

            // Controls
            SimulationControls {
                id: simulationControls
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredHeight: 60
                Layout.minimumHeight: 60
                Layout.maximumHeight: 60

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
                    window.simulationElapsedSeconds = 0
                    leftMonitoringPanel.clearEcgSamples()
                    rightMonitoringPanel.resetHeartbeat()
                }
            }
        }
    }

    Connections {
        target: simulationController

        function onEcgSampleGenerated(sample) {            
            leftMonitoringPanel.addEcgSample(sample)
            window.hasSimulationData = true
        }

        function onHeartbeatOccurred() {
            rightMonitoringPanel.triggerHeartbeat()
        }
    }

    Component.onCompleted: {
        console.log("Dashboard:", dashboardPanel.width, dashboardPanel.height)
        console.log("Monitoring:", monitoringLayout.width, monitoringLayout.height)
        console.log("Left:", leftMonitoringPanel.width, leftMonitoringPanel.height)
        console.log("Right:", rightMonitoringPanel.width, rightMonitoringPanel.height)
    }
}
