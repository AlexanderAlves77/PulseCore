import QtQuick
import QtQuick.Layouts

import "../Controls"
import "../DesignSystem"

Rectangle {
    id: root

    property string patientName: "Adult"
    property string scenarioName: "Normal"
    property string simulationTime: "00:00:00"

    property color surfaceColor: "#07121D"
    property color titleColor: "#F2F7FC"
    property color secondaryColor: "#9AB6C8"
    property color accentColor: "#00DDF2"
    property color borderColor: "#16435A"

    property int batteryLevel: 100
    property int headerHeight: 76
    property int horizontalPadding: 24
    property int componentSpacing: 16
    property int dividerHeight: 38

    property date currentDateTime: new Date()

    readonly property string currentDate: Qt.formatDate(root.currentDateTime, "dd/MM/yyyy")

    readonly property string currentTime: Qt.formatTime(root.currentDateTime, "HH:mm:ss")

    signal scenarioRequested()
    signal settingsRequested()

    color: surfaceColor
    implicitHeight: headerHeight

    Timer {
        id: clockTimer

        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true

        onTriggered: {
            root.currentDateTime = new Date()
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: root.horizontalPadding
        anchors.rightMargin: root.horizontalPadding
        spacing: root.componentSpacing

        Item {
            Layout.fillWidth: true
            Layout.minimumWidth: 230
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

        HeaderPatient {
            patientName: root.patientName
            patientType: "Simulation"
            Layout.preferredWidth: 135
            Layout.alignment: Qt.AlignVCenter
        }

        PulseDivider {
            vertical: true
            dividerLength: root.dividerHeight
            dividerColor: root.borderColor
            Layout.alignment: Qt.AlignVCenter
        }

        HeaderScenario {
            scenarioName: root.scenarioName
            Layout.preferredWidth: 155
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

        ColumnLayout {
            Layout.preferredWidth: 195
            Layout.alignment: Qt.AlignVCenter

            spacing: 3

            HeaderClock {
                title: "Date & Time"

                showDate: true
                showTime: true

                dateText: root.currentDate
                timeText: root.currentTime

                iconSize: 23
                valueSize: 12
                contentSpacing: 7
            }

            RowLayout {
                Layout.leftMargin: 30
                spacing: 6

                PulseLabel {
                    text: "Simulation"
                    labelColor: root.secondaryColor
                    labelSize: 10
                }

                PulseLabel {
                    text: root.simulationTime
                    labelColor: root.accentColor
                    labelSize: 11
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

        HeaderActions {
            batteryLevel: root.batteryLevel

            batteryIconSize: 28
            batteryTextSize: 13
            batterySpacing: 6

            settingsButtonSize: 42
            settingsIconSize: 25

            contentSpacing: 12

            Layout.alignment: Qt.AlignVCenter

            onSettingsRequested: {
                root.settingsRequested()
            }
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
        color: root.borderColor
    }
}
