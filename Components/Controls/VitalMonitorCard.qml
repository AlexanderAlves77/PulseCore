import QtQuick
import QtQuick.Layouts
import "../DesignSystem"

PulseCard {
    id: root

    property string title: "Oxygen Saturation"
    property string subtitle: "SpO2 %"
    property string iconName: "lungs"
    property string status: "NORMAL"
    property string fontFamily: "Segoe UI"
    property string unit: ""
    property string detailTitle: ""
    property string detailValue: ""
    property string detailUnit: ""

    property color accentColor: "#00DDF2"
    property color titleColor: "#F2F7FC"
    property color secondaryColor: "#9AB6C8"
    property color detailBackgroundColor: "#07121D"

    property int decimals: 0
    property int titleSize: 12
    property int subtitleSize: 10
    property int valueSize: 38
    property int iconSize: 28
    property int cardHeight: 72
    property int contentSpacing: 8
    property int signalStrength: 0

    property real value: 0.0
    property real scaleMaximum: 100
    property real scaleMinimum: 85
    property real temperatureT1: 0.0
    property real temperatureT2: 0.0
    property real temperatureDelta: 0.0

    property bool showIcon: true
    property bool showStatus: true
    property bool showScale: true
    property bool showDetails: false
    property bool hasData: false
    property bool showSignal: false
    property bool hasTemperatureT1: false
    property bool hasTemperatureT2: false
    property bool hasTemperatureDelta: false
    property bool showTemperatureDetails: false

    readonly property int displayedSignalStrength: Math.max(0, Math.min(4, signalStrength))

    readonly property bool compactMode: height < 76

    readonly property int effectiveIconSize: compactMode ? 25 : iconSize

    readonly property int effectiveValueSize: compactMode ? 34 : valueSize

    preferredWidth: 500
    preferredHeight: cardHeight

    contentPadding: compactMode ? 8 : 10

    RowLayout {
        id: contentLayout
        anchors.fill: parent
        spacing: root.contentSpacing

        PulseIcon {
            iconName: root.iconName
            iconColor: root.accentColor
            iconSize: root.effectiveIconSize

            visible: root.showIcon

            Layout.preferredWidth: root.effectiveIconSize
            Layout.preferredHeight: root.effectiveIconSize
            Layout.alignment: Qt.AlignVCenter
        }

        ColumnLayout {
            Layout.preferredWidth: 125
            Layout.minimumWidth: 95
            Layout.alignment: Qt.AlignVCenter

            spacing: 3

            PulseLabel {
                text: root.title
                labelColor: root.titleColor
                labelSize: root.compactMode ? 11 : root.titleSize
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

            valueSize: root.effectiveValueSize
            unitSize: 11
            fontFamily: root.fontFamily

            Layout.preferredWidth: 85
            Layout.minimumWidth: 65
            Layout.alignment: Qt.AlignVCenter
        }

        RowLayout {
            visible: root.showScale
            spacing: 5
            Layout.alignment: Qt.AlignVCenter

            Rectangle {
                implicitWidth: 3
                implicitHeight: root.compactMode ? 28 : 36
                radius: 2
                color: root.accentColor
            }

            ColumnLayout {
                spacing: root.compactMode ? 3 : 8

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
            Layout.minimumWidth: 0
        }

        ColumnLayout {
            id: detailsLayout

            Layout.preferredWidth: root.showTemperatureDetails ? 120 : 84

            Layout.minimumWidth: root.showTemperatureDetails ? 105 : 75

            Layout.alignment: Qt.AlignVCenter

            spacing: root.compactMode ? 2 : 4

            Rectangle {
                visible: root.showDetails

                Layout.fillWidth: true
                Layout.preferredHeight: root.compactMode ? 27 : 34

                radius: 5
                color: root.detailBackgroundColor

                border.color: root.borderColor
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 3
                    spacing: 0

                    PulseLabel {
                        text: root.detailTitle
                        labelColor: root.secondaryColor
                        labelSize: 9
                    }

                    PulseLabel {
                        text: root.detailValue
                              + (root.detailUnit.length > 0 ? " " + root.detailUnit : "")

                        labelColor: root.accentColor
                        labelSize: 11
                        emphasized: true
                    }
                }
            }

            RowLayout {
                visible: root.showSignal

                Layout.alignment: Qt.AlignHCenter
                spacing: 3

                Rectangle {
                    implicitWidth: 4
                    implicitHeight: 7
                    radius: 2

                    color: root.displayedSignalStrength >= 1
                           ? root.accentColor : root.secondaryColor
                }

                Rectangle {
                    implicitWidth: 4
                    implicitHeight: 11
                    radius: 2

                    color: root.displayedSignalStrength >= 2
                           ? root.accentColor : root.secondaryColor
                }

                Rectangle {
                    implicitWidth: 4
                    implicitHeight: 15
                    radius: 2

                    color: root.displayedSignalStrength >= 3
                           ? root.accentColor : root.secondaryColor
                }

                Rectangle {
                    implicitWidth: 4
                    implicitHeight: 19
                    radius: 2

                    color: root.displayedSignalStrength >= 4
                           ? root.accentColor : root.secondaryColor
                }
            }

            RowLayout {
                visible: root.showTemperatureDetails

                Layout.alignment: Qt.AlignHCenter
                spacing: 7

                ColumnLayout {
                    spacing: 1

                    PulseLabel {
                        text: "T1"
                        labelColor: root.secondaryColor
                        labelSize: 9
                    }

                    PulseLabel {
                        text: root.hasTemperatureT1 ? root.temperatureT1.toFixed(1) : "--"
                        labelColor: root.accentColor
                        labelSize: 11
                        emphasized: true
                    }
                }

                ColumnLayout {
                    spacing: 1

                    PulseLabel {
                        text: "T2"
                        labelColor: root.secondaryColor
                        labelSize: 9
                    }

                    PulseLabel {
                        text: root.hasTemperatureT2 ? root.temperatureT2.toFixed(1) : "--"
                        labelColor: root.accentColor
                        labelSize: 11
                        emphasized: true
                    }
                }

                ColumnLayout {
                    spacing: 1

                    PulseLabel {
                        text: "?T"
                        labelColor: root.secondaryColor
                        labelSize: 9
                    }

                    PulseLabel {
                        text: root.hasTemperatureDelta ? root.temperatureDelta.toFixed(1) : "--"
                        labelColor: root.accentColor
                        labelSize: 11
                        emphasized: true
                    }
                }
            }

            PulseBadge {
                status: root.hasData ? root.status : "NO DATA"
                visible: root.showStatus
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
