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
    implicitHeight: 64

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 18
        anchors.rightMargin: 18
        spacing: 14

        RowLayout {
            Layout.preferredWidth: 310
            spacing: 10

            Canvas {
                id: logoCanvas

                Layout.preferredWidth: 48
                Layout.preferredHeight: 40

                onPaint: {
                    const context = getContext("2d")

                    context.reset()
                    context.strokeStyle = "#00DDF2"
                    context.lineWidth = 2
                    context.lineJoin = "round"

                    context.beginPath()
                    context.moveTo(0, 20)
                    context.lineTo(10, 20)
                    context.lineTo(15, 15)
                    context.lineTo(20, 27)
                    context.lineTo(25, 4)
                    context.lineTo(30, 35)
                    context.lineTo(35, 20)
                    context.lineTo(48, 20)
                    context.stroke()
                }
            }

            ColumnLayout {
                spacing: 0

                Text {
                    text: "PulseCore"
                    color: root.titleColor
                    font.pixelSize: 26
                    font.bold: true
                }

                Text {
                    text: "MEDICAL DEVICE MONITORING SIMULATOR"
                    color: "#9AB6C8"
                    font.pixelSize: 9
                }
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

        Rectangle {
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            Layout.topMargin: 12
            Layout.bottomMargin: 12
            color: "#16435A"
        }

        Item {
            Layout.preferredWidth: 150
            Layout.preferredHeight: 44

            ColumnLayout {
                anchors.fill: parent
                spacing: 3

                Text {
                    text: "Scenario"
                    color: "#9AB6C8"
                    font.pixelSize: 11
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 26

                    radius: 6
                    color: "#061D19"
                    border.color: "#087B60"

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter

                        text: root.scenarioName
                        color: root.accentColor
                        font.pixelSize: 13
                        font.bold: true
                    }

                    Text {
                        anchors.right: parent.right
                        anchors.rightMargin: 9
                        anchors.verticalCenter: parent.verticalCenter

                        text: "?"
                        color: root.accentColor
                        font.pixelSize: 17
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.scenarioRequested()
                    }
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            Layout.topMargin: 12
            Layout.bottomMargin: 12
            color: "#16435A"
        }

        HeaderInfo {
            Layout.preferredWidth: 130
            title: "Simulation Time"
            value: root.simulationTime
        }

        Item {
            Layout.fillWidth: true
        }

        RowLayout {
            spacing: 8

            Rectangle {
                Layout.preferredWidth: 30
                Layout.preferredHeight: 16

                radius: 2
                color: "transparent"
                border.color: root.accentColor
                border.width: 2

                Rectangle {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 3

                    width: Math.max(
                        0,
                        (parent.width - 6) * root.batteryLevel / 100
                    )

                    color: root.accentColor
                }
            }

            Text {
                text: root.batteryLevel + "%"
                color: "#A9E8F2"
                font.pixelSize: 13
            }
        }

        Rectangle {
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            Layout.topMargin: 12
            Layout.bottomMargin: 12
            color: "#16435A"
        }

        Text {
            text: "?"
            color: "#9AB6C8"
            font.pixelSize: 25

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.settingsRequested()
            }
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: "#16435A"
    }
}