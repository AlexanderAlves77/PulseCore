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
    property color accentColor: "#21F58B"
    property color borderColor: "#16435A"

    property int batteryLevel: 100
    property int headerHeight: 64
    property int horizontalPadding: 18
    property int componentSpacing: 12
    property int dividerHeight: 34

    signal scenarioRequested()
    signal settingsRequested()

    color: surfaceColor
    implicitHeight: headerHeight

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: root.horizontalPadding
        anchors.rightMargin: root.horizontalPadding
        spacing: root.componentSpacing

        HeaderBrand {
            Layout.alignment: Qt.AlignVCenter
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

        HeaderClock {
            title: "Simulation Time"
            showDate: false
            showTime: true
            timeText: root.simulationTime
            Layout.alignment: Qt.AlignVCenter
        }

        Item {
            Layout.fillWidth: true
        }

        HeaderActions {
            batteryLevel: root.batteryLevel
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
