import QtQuick
import QtQuick.Layouts
import "../DesignSystem"

PulseCard {
    id: root

    property string title: "Oxygen Saturation"
    property string subtitle: "SpO₂ %"
    property string iconName: "heart"
    property string status: "NORMAL"
    property string fontFamily: "Segoe UI"
    property string unit: ""
    property string detailTitle: ""
    property string detailValue: ""
    property string detailUnit: ""

    property color accentColor: "#00DDF2"
    property color titleColor: "#F2F7FC"
    property color secondaryColor: "#9AB6C8"

    property int titleSize: 12
    property int subtitleSize: 10
    property int valueSize: 42
    property int iconSize: 34
    property int decimals: 0
    property int cardHeight: 72
    property int contentSpacing: 10

    property real value: 0.0
    property real scaleMaximum: 100
    property real scaleMinimum: 85

    property bool hasData: false
    property bool showScale: true
    property bool showDetails: false
    property bool showStatus: true
    property bool showIcon: true

    preferredWidth: 500
    preferredHeight: cardHeight
    contentPadding: 10

    RowLayout {
        anchors.fill: parent
        spacing: root.contentSpacing

        PulseIcon {
            iconName: root.iconName
            iconColor: root.accentColor
            iconSize: root.iconSize

            visible: root.showIcon
            Layout.alignment: Qt.AlignVCenter
        }

        ColumnLayout {
            Layout.preferredWidth: 145
            Layout.alignment: Qt.AlignVCenter
            spacing: 3

            PulseLabel {
                text: root.title
                labelColor: root.titleColor
                labelSize: root.titleSize
                fontFamily: root.fontFamily
                emphasized: true
            }

            PulseLabel {
                text: root.subtitle
                labelColor: root.secondaryColor
                labelSize: root.subtitleSize
                fontFamily: root.fontFamily
            }
        }

        PulseNumber {
            value: root.value
            decimals: root.decimals
            hasData: root.hasData
            unit: root.unit

            valueColor: root.accentColor
            unitColor: root.secondaryColor

            valueSize: root.valueSize
            unitSize: 11
            fontFamily: root.fontFamily

            Layout.preferredWidth: 90
            Layout.alignment: Qt.AlignVCenter
        }

        RowLayout {
            visible: root.showScale

            spacing: 5
            Layout.alignment: Qt.AlignVCenter

            Rectangle {
                implicitWidth: 3
                implicitHeight: 34
                radius: 2
                color: root.accentColor
            }

            ColumnLayout {
                spacing: 8

                PulseLabel {
                    text: root.scaleMaximum.toString()
                    labelColor: root.secondaryColor
                    labelSize: 9
                }

                PulseLabel {
                    text: root.scaleMinimum.toString()
                    labelColor: root.secondaryColor
                    labelSize: 9
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }

        ColumnLayout {
            Layout.preferredWidth: 85
            Layout.alignment: Qt.AlignVCenter
            spacing: 4

            Rectangle {
                visible: root.showDetails

                Layout.fillWidth: true
                Layout.preferredHeight: 34

                radius: 5
                color: "#07121D"
                border.color: "#16435A"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 4
                    spacing: 0

                    PulseLabel {
                        text: root.detailTitle
                        labelColor: root.secondaryColor
                        labelSize: 9
                    }

                    PulseLabel {
                        text: root.detailValue
                              + (root.detailUnit.length > 0
                                 ? " " + root.detailUnit
                                 : "")

                        labelColor: root.accentColor
                        labelSize: 12
                        emphasized: true
                    }
                }
            }

            PulseBadge {
                status: root.hasData
                        ? root.status
                        : "NO DATA"

                visible: root.showStatus
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
