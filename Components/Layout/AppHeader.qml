import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    property color surfaceColor: "#07121D"
    property color titleColor: "#F2F7FC"
    property color accentColor: "#21F58B"

    property string patientName: "Adult"
    property string scenarioName: "Normal"
    property string simulationTime: "00:00:00"

    signal scenarioRequested()
    signal settingsRequested()

    color: surfaceColor

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 20

        ColumnLayout {
            Layout.preferredWidth: 310
            spacing: 2

            Text {
                text: "PulseCore"
                color: root.titleColor
                font.pixelSize: 28
                font.bold: true
            }

            Text {
                text: "MEDICAL DEVICE MONITORING SIMULATOR"
                color: "#9AB6C8"
                font.pixelSize: 10
            }
        }

        Rectangle {
            width: 1
            Layout.fillHeight: true
            Layout.topMargin: 12
            Layout.bottomMargin: 12
            color: "#16435A"
        }

        HeaderInfo {
            Layout.preferredWidth: 150
            title: "Patient"
            value: root.patientName + " · Simulation"
        }

        HeaderInfo {
            Layout.preferredWidth: 140
            title: "Scenario"
            value: root.scenarioName
            valueColor: root.accentColor
        }

        HeaderInfo {
            Layout.preferredWidth: 120
            title: "Time"
            value: root.simulationTime
        }

        Item {
            Layout.fillWidth: true
        }

        Text {
            text: "100%"
            color: root.accentColor
            font.pixelSize: 14
        }

        Text {
            text: "⚙"
            color: "#9AB6C8"
            font.pixelSize: 24
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: "#16435A"
    }
}