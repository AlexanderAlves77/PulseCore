import QtQuick
import QtQuick.Layouts

import "Components/DesignSystem"
import "Components/Layout"
import "Components/Monitoring"

Window {
    id: window

    PulseTheme {
        id: theme
    }

    // Window configuration
    width: 1280
    height: 800
    minimumWidth: 1100
    minimumHeight: 700

    visible: true
    title: "PulseCore - Medical Device Monitoring Simulator"
    color: theme.background

    // Simulation state
    property bool hasSimulationData: false
    property int simulationElapsedSeconds: 0

    readonly property string simulationState:
        simulationController.state

    readonly property string formattedSimulationTime:
    {
        const hours = Math.floor(window.simulationElapsedSeconds / 3600)

        const minutes = Math.floor((window.simulationElapsedSeconds % 3600) / 60)

        const seconds = window.simulationElapsedSeconds % 60

        return String(hours).padStart(2, "0") + ":"
             + String(minutes).padStart(2, "0") + ":"
             + String(seconds).padStart(2, "0")
    }

    // Main layout configuration
    readonly property int layoutMargin: theme.spacingTiny
    readonly property int layoutSpacing: theme.spacingSmall

    readonly property int headerHeight: theme.appHeaderHeight
    readonly property int footerHeight: theme.appFooterHeight

    readonly property int controlsHeight: 60

    readonly property real leftPanelRatio: 0.62
    readonly property real rightPanelRatio: 0.38

    // Simulation clock
    Timer {
        id: simulationTimer
        interval: theme.appHeaderClockInterval
        repeat: true
        running: window.simulationState === "RUNNING"

        onTriggered: {
            window.simulationElapsedSeconds++
        }
    }

    // Application header
    AppHeader {
        id: appHeader

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        height: window.headerHeight

        patientName: theme.defaultPatientName
        scenarioName: theme.defaultScenarioName
        simulationTime: window.formattedSimulationTime

        batteryLevel: theme.headerBatteryLevel

        onScenarioRequested: {
            console.log("Scenario selection is not implemented yet")
        }

        onSettingsRequested: {
            console.log("Settings panel is not implemented yet")
        }
    }

    // Main dashboard
    DashboardPanel {
        id: dashboardPanel

        anchors.top: appHeader.bottom
        anchors.bottom: appFooter.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: window.layoutMargin
        anchors.bottomMargin: window.layoutMargin
        anchors.leftMargin: window.layoutMargin
        anchors.rightMargin: window.layoutMargin

        backgroundColor: theme.background
        surfaceColor: theme.dashboardSurfaceColor
        borderColor: theme.dashboardBorderColor

        ColumnLayout {
            id: dashboardLayout

            anchors.fill: parent
            spacing: window.layoutSpacing

            // Monitoring area
            RowLayout {
                id: monitoringLayout

                Layout.fillWidth: true
                Layout.fillHeight: true

                Layout.minimumHeight: 0

                spacing: window.layoutSpacing

                // Left monitoring panel
                LeftMonitoringPanel {
                    id: leftMonitoringPanel

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Layout.minimumWidth: 350
                    Layout.minimumHeight: 0

                    Layout.preferredWidth: window.leftPanelRatio * 1000

                    // Synchronize waveforms with the simulation controller
                    heartRate: simulationController.heartRate
                    respiratoryRate: simulationController.respiratoryRate
                }

                // Right monitoring panel
                RightMonitoringPanel {
                    id: rightMonitoringPanel

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Layout.minimumWidth: 280
                    Layout.minimumHeight: 0

                    Layout.preferredWidth:
                        window.rightPanelRatio * 1000

                    heartRate: simulationController.heartRate

                    oxygenSaturation:
                        simulationController.oxygenSaturation

                    respiratoryRate:
                        simulationController.respiratoryRate

                    temperature:
                        simulationController.temperature

                    running:
                        window.simulationState === "RUNNING"

                    hasData: window.hasSimulationData
                }
            }

            // Simulation controls
            SimulationControls {
                id: simulationControls

                Layout.fillWidth: true
                Layout.fillHeight: false

                Layout.preferredHeight: window.controlsHeight
                Layout.minimumHeight: window.controlsHeight
                Layout.maximumHeight: window.controlsHeight

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

    // Application footer
    AppFooter {
        id: appFooter

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        height: window.footerHeight
    }

    // Simulation events
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
        console.log(
            "Dashboard:",
            dashboardPanel.width,
            dashboardPanel.height
        )

        console.log(
            "Monitoring:",
            monitoringLayout.width,
            monitoringLayout.height
        )
    }
}
