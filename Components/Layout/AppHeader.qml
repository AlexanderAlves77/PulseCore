import QtQuick
import QtQuick.Layouts

import "../Controls"
import "../DesignSystem"

Rectangle {
    id: root

    PulseTheme {
        id: theme
    }

    // Header information
    property string patientName: theme.appHeaderPatientName
    property string scenarioName: theme.appHeaderScenarioName
    property string simulationTime: theme.appHeaderSimulationTime
    property string simulationLabel: theme.appHeaderSimulationLabel

    // Colors
    property color surfaceColor: theme.appHeaderBackground
    property color titleColor: theme.appHeaderTitleColor
    property color secondaryColor: theme.appHeaderSecondaryColor
    property color accentColor: theme.appHeaderAccentColor
    property color borderColor: theme.appHeaderBorderColor

    // Geometry
    property int headerHeight: theme.appHeaderHeight
    property int horizontalPadding: theme.appHeaderHorizontalPadding
    property int componentSpacing: theme.appHeaderComponentSpacing
    property int dividerHeight: theme.appHeaderDividerHeight

    // Component widths
    property int brandMinimumWidth: theme.appHeaderBrandMinimumWidth
    property int patientWidth: theme.appHeaderPatientWidth
    property int scenarioWidth: theme.appHeaderScenarioWidth
    property int clockWidth: theme.appHeaderClockWidth

    // Clock configuration
    property int clockIconSize: theme.appHeaderClockIconSize
    property int clockValueSize: theme.appHeaderClockValueSize
    property int clockSpacing: theme.appHeaderClockSpacing
    property int clockColumnSpacing: theme.appHeaderClockColumnSpacing
    property int clockInterval: theme.appHeaderClockInterval

    // Simulation information
    property int simulationLeftMargin: theme.appHeaderSimulationLeftMargin
    property int simulationSpacing: theme.appHeaderSimulationSpacing
    property int simulationLabelSize: theme.appHeaderSimulationLabelSize
    property int simulationValueSize: theme.appHeaderSimulationValueSize

    // Action configuration
    property int batteryLevel: theme.headerBatteryLevel
    property int batteryIconSize: theme.appHeaderBatteryIconSize
    property int batteryTextSize: theme.appHeaderBatteryTextSize
    property int batterySpacing: theme.appHeaderBatterySpacing
    property int settingsButtonSize: theme.appHeaderSettingsButtonSize
    property int settingsIconSize: theme.appHeaderSettingsIconSize
    property int actionsSpacing: theme.appHeaderActionsSpacing

    // Clock state
    property date currentDateTime: new Date()

    readonly property string currentDate:
        Qt.formatDate(
            root.currentDateTime,
            theme.appHeaderDateFormat
        )

    readonly property string currentTime:
        Qt.formatTime(
            root.currentDateTime,
            theme.appHeaderTimeFormat
        )

    // Events
    signal scenarioRequested()
    signal settingsRequested()

    color: root.surfaceColor
    implicitHeight: root.headerHeight

    // Real-time clock
    Timer {
        id: clockTimer

        interval: root.clockInterval
        repeat: true
        running: true
        triggeredOnStart: true

        onTriggered: {
            root.currentDateTime = new Date()
        }
    }

    // Header composition
    RowLayout {
        id: headerContent

        anchors.fill: parent
        anchors.leftMargin: root.horizontalPadding
        anchors.rightMargin: root.horizontalPadding

        spacing: root.componentSpacing

        // Brand
        Item {
            Layout.fillWidth: true
            Layout.minimumWidth: root.brandMinimumWidth
            Layout.alignment: Qt.AlignVCenter
            implicitHeight: brand.implicitHeight

            HeaderBrand {
                id: brand
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        PulseDivider {
            vertical: true
            dividerLength: root.dividerHeight
            dividerColor: root.borderColor
            Layout.alignment: Qt.AlignVCenter
        }

        // Patient
        HeaderPatient {
            patientName: root.patientName
            patientType: theme.defaultPatientType
            Layout.preferredWidth: root.patientWidth
            Layout.alignment: Qt.AlignVCenter
        }

        PulseDivider {
            vertical: true
            dividerLength: root.dividerHeight
            dividerColor: root.borderColor
            Layout.alignment: Qt.AlignVCenter
        }

        // Scenario
        HeaderScenario {
            scenarioName: root.scenarioName
            Layout.preferredWidth: root.scenarioWidth
            Layout.alignment: Qt.AlignVCenter

            onScenarioRequested: {
                root.scenarioRequested()
            }
        }

        PulseDivider {
            vertical: true
            dividerLength: root.dividerHeight
            dividerColor: root.borderColor
            Layout.alignment: Qt.AlignVCenter
        }

        // Clock and simulation time
        ColumnLayout {
            id: clockSection
            Layout.preferredWidth: root.clockWidth
            Layout.alignment: Qt.AlignVCenter
            spacing: root.clockColumnSpacing

            HeaderClock {
                title: theme.clockTitle

                showDate: theme.clockShowDate
                showTime: theme.clockShowTime

                dateText: root.currentDate
                timeText: root.currentTime

                iconSize: root.clockIconSize
                valueSize: root.clockValueSize
                contentSpacing: root.clockSpacing
            }

            RowLayout {
                Layout.leftMargin: root.simulationLeftMargin
                spacing: root.simulationSpacing

                PulseLabel {
                    text: root.simulationLabel
                    labelColor: root.secondaryColor
                    labelSize: root.simulationLabelSize
                    fontFamily: theme.fontFamily
                }

                PulseLabel {
                    text: root.simulationTime
                    labelColor: root.accentColor
                    labelSize: root.simulationValueSize
                    fontFamily: theme.fontFamily
                    emphasized: true
                }
            }
        }

        PulseDivider {
            vertical: true
            dividerLength: root.dividerHeight
            dividerColor: root.borderColor
            Layout.alignment: Qt.AlignVCenter
        }

        // Battery and settings
        HeaderActions {
            batteryLevel: root.batteryLevel

            batteryIconSize: root.batteryIconSize
            batteryTextSize: root.batteryTextSize
            batterySpacing: root.batterySpacing

            settingsButtonSize: root.settingsButtonSize
            settingsIconSize: root.settingsIconSize

            contentSpacing: root.actionsSpacing

            Layout.alignment: Qt.AlignVCenter

            onSettingsRequested: {
                root.settingsRequested()
            }
        }
    }

    // Bottom separator
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: theme.dividerThickness
        color: root.borderColor
    }
}
