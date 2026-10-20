import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

PulseCard {
    id: root

    PulseTheme {
        id: theme
    }

    // Monitor information
    property string title: theme.monitorDefaultTitle
    property string subtitle: theme.monitorDefaultSubtitle
    property string iconName: theme.monitorDefaultIconName
    property string status: theme.monitorDefaultStatus
    property string fontFamily: theme.fontFamily
    property string unit: ""

    // Additional information
    property string detailTitle: ""
    property string detailValue: ""
    property string detailUnit: ""

    // Temperature labels
    property string temperatureT1Label: theme.monitorTemperatureT1Label
    property string temperatureT2Label: theme.monitorTemperatureT2Label
    property string temperatureDeltaLabel: theme.monitorTemperatureDeltaLabel
    property string unavailableValue: theme.monitorUnavailableValue

    // Colors
    property color accentColor: theme.monitorAccentColor
    property color titleColor: theme.monitorTitleColor
    property color secondaryColor: theme.monitorSecondaryColor
    property color detailBackgroundColor: theme.monitorDetailBackgroundColor

    // Typography
    property int decimals: 0
    property int titleSize: theme.monitorTitleSize
    property int subtitleSize: theme.monitorSubtitleSize
    property int valueSize: theme.monitorValueSize
    property int iconSize: theme.monitorIconSize

    // Layout
    property int cardHeight: theme.monitorCardHeight
    property int contentSpacing: theme.monitorContentSpacing

    // Measurements
    property real value: 0.0
    property real scaleMinimum: theme.monitorScaleMinimum
    property real scaleMaximum: theme.monitorScaleMaximum

    property real temperatureT1: 0.0
    property real temperatureT2: 0.0
    property real temperatureDelta: 0.0

    // Signal
    property int signalStrength: 0

    // Visibility
    property bool showIcon: true
    property bool showStatus: true
    property bool showScale: true
    property bool showDetails: false
    property bool hasData: false
    property bool showSignal: false
    property bool showTemperatureDetails: false

    // Temperature availability
    property bool hasTemperatureT1: false
    property bool hasTemperatureT2: false
    property bool hasTemperatureDelta: false

    // Derived state
    readonly property bool compactMode: height < theme.monitorCompactThreshold

    readonly property int effectiveIconSize: compactMode ? theme.monitorCompactIconSize : iconSize

    readonly property int effectiveValueSize: compactMode ? theme.monitorCompactValueSize : valueSize

    readonly property int effectiveBadgeHeight: compactMode ? 20 : theme.badgeHeight

    readonly property int effectiveBadgeTextSize: compactMode ? theme.fontTiny : theme.fontLabel

    readonly property int displayedSignalStrength:
        Math.max(
            0,
            Math.min(theme.monitorSignalMaximum, signalStrength)
        )

    preferredWidth: theme.monitorCardWidth
    preferredHeight: cardHeight

    contentPadding: compactMode ? theme.monitorCompactPadding : theme.monitorRegularPadding

    RowLayout {
        id: contentLayout

        anchors.fill: parent
        spacing: root.compactMode ? theme.spacingCompact : root.contentSpacing

        // Medical icon
        PulseIcon {
            id: monitorIcon

            iconName: root.iconName
            iconColor: root.accentColor
            iconSize: root.effectiveIconSize

            visible: root.showIcon

            Layout.preferredWidth: root.effectiveIconSize
            Layout.preferredHeight: root.effectiveIconSize
            Layout.alignment: Qt.AlignVCenter
        }

        // Monitor identification
        ColumnLayout {
            id: monitorInformation

            Layout.preferredWidth: theme.monitorTitleWidth
            Layout.minimumWidth: 75
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            spacing: theme.spacingTiny

            PulseLabel {
                text: root.title

                labelColor: root.titleColor
                labelSize: root.compactMode ? theme.monitorCompactTitleSize : root.titleSize

                fontFamily: root.fontFamily
                emphasized: true

                Layout.fillWidth: true
            }

            PulseLabel {
                text: root.subtitle

                labelColor: root.secondaryColor
                labelSize: root.subtitleSize
                fontFamily: root.fontFamily

                Layout.fillWidth: true
            }
        }

        // Primary measurement
        PulseNumber {
            id: monitorValue

            value: root.value
            decimals: root.decimals
            hasData: root.hasData
            unit: root.unit

            valueColor: root.accentColor
            unitColor: root.secondaryColor

            valueSize: root.effectiveValueSize
            unitSize: theme.monitorUnitSize
            fontFamily: root.fontFamily

            Layout.preferredWidth: theme.monitorValueWidth
            Layout.minimumWidth: theme.monitorValueMinimumWidth
            Layout.alignment: Qt.AlignVCenter
        }

        // Measurement scale
        RowLayout {
            id: monitorScale

            visible: root.showScale

            spacing: theme.monitorScaleSpacing
            Layout.alignment: Qt.AlignVCenter

            Rectangle {
                implicitWidth: theme.monitorScaleBarWidth

                implicitHeight: root.compactMode
                                ? theme.monitorCompactScaleBarHeight
                                : theme.monitorScaleBarHeight

                radius: theme.monitorSignalBarRadius
                color: root.accentColor
            }

            ColumnLayout {
                spacing: root.compactMode ? theme.spacingTiny : theme.spacingSmall

                PulseLabel {
                    text: root.scaleMaximum.toString()
                    labelColor: root.secondaryColor
                    labelSize: theme.monitorScaleSize
                }

                PulseLabel {
                    text: root.scaleMinimum.toString()
                    labelColor: root.secondaryColor
                    labelSize: theme.monitorScaleSize
                }
            }
        }

        // Status and additional measurements
        ColumnLayout {
            id: detailsLayout

            Layout.preferredWidth: root.showTemperatureDetails
                                   ? theme.monitorTemperatureWidth
                                   : theme.monitorDetailWidth

            Layout.minimumWidth: root.showTemperatureDetails
                                 ? theme.monitorTemperatureMinimumWidth
                                 : theme.monitorDetailMinimumWidth

            Layout.alignment: Qt.AlignVCenter

            spacing: root.compactMode
                     ? theme.monitorCompactDetailSpacing : theme.monitorDetailSpacing

            // Additional measurement
            Rectangle {
                id: detailPanel

                visible: root.showDetails

                Layout.fillWidth: true
                Layout.preferredHeight: root.compactMode
                                        ? theme.monitorCompactDetailHeight
                                        : theme.monitorDetailHeight

                radius: theme.monitorDetailRadius
                color: root.detailBackgroundColor

                border.color: root.borderColor
                border.width: theme.borderThin

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: theme.monitorDetailPadding
                    spacing: 0

                    PulseLabel {
                        text: root.detailTitle
                        labelColor: root.secondaryColor
                        labelSize: theme.monitorDetailTitleSize
                    }

                    PulseLabel {
                        text: root.detailValue
                              + (root.detailUnit.length > 0 ? " " + root.detailUnit : "")

                        labelColor: root.accentColor
                        labelSize: theme.monitorDetailValueSize
                        emphasized: true
                    }
                }
            }

            // Signal strength
            RowLayout {
                id: signalIndicator

                visible: root.showSignal

                Layout.alignment: Qt.AlignHCenter
                spacing: theme.monitorSignalBarSpacing

                Rectangle {
                    implicitWidth: theme.monitorSignalBarWidth
                    implicitHeight: theme.monitorSignalBarHeight1
                    radius: theme.monitorSignalBarRadius

                    color: root.displayedSignalStrength >= 1
                           ? root.accentColor : root.secondaryColor
                }

                Rectangle {
                    implicitWidth: theme.monitorSignalBarWidth
                    implicitHeight: theme.monitorSignalBarHeight2
                    radius: theme.monitorSignalBarRadius

                    color: root.displayedSignalStrength >= 2
                           ? root.accentColor : root.secondaryColor
                }

                Rectangle {
                    implicitWidth: theme.monitorSignalBarWidth
                    implicitHeight: theme.monitorSignalBarHeight3
                    radius: theme.monitorSignalBarRadius

                    color: root.displayedSignalStrength >= 3
                           ? root.accentColor : root.secondaryColor
                }

                Rectangle {
                    implicitWidth: theme.monitorSignalBarWidth
                    implicitHeight: theme.monitorSignalBarHeight4
                    radius: theme.monitorSignalBarRadius

                    color: root.displayedSignalStrength >= 4
                           ? root.accentColor : root.secondaryColor
                }
            }

            // Temperature details
            RowLayout {
                id: temperatureDetails

                visible: root.showTemperatureDetails

                Layout.alignment: Qt.AlignHCenter
                spacing: theme.monitorTemperatureSpacing

                ColumnLayout {
                    spacing: 0

                    PulseLabel {
                        text: root.temperatureT1Label
                        labelColor: root.secondaryColor
                        labelSize: theme.monitorDetailTitleSize
                    }

                    PulseLabel {
                        text: root.hasTemperatureT1
                              ? root.temperatureT1.toFixed(1) : root.unavailableValue

                        labelColor: root.accentColor
                        labelSize: theme.monitorDetailValueSize
                        emphasized: true
                    }
                }

                ColumnLayout {
                    spacing: 0

                    PulseLabel {
                        text: root.temperatureT2Label
                        labelColor: root.secondaryColor
                        labelSize: theme.monitorDetailTitleSize
                    }

                    PulseLabel {
                        text: root.hasTemperatureT2
                              ? root.temperatureT2.toFixed(1) : root.unavailableValue

                        labelColor: root.accentColor
                        labelSize: theme.monitorDetailValueSize
                        emphasized: true
                    }
                }

                ColumnLayout {
                    spacing: 0

                    PulseLabel {
                        text: root.temperatureDeltaLabel
                        labelColor: root.secondaryColor
                        labelSize: theme.monitorDetailTitleSize
                    }

                    PulseLabel {
                        text: root.hasTemperatureDelta
                              ? root.temperatureDelta.toFixed(1) : root.unavailableValue

                        labelColor: root.accentColor
                        labelSize: theme.monitorDetailValueSize
                        emphasized: true
                    }
                }
            }

            // Clinical status
            PulseBadge {
                id: monitorStatus

                status: root.hasData ? root.status : theme.monitorNoDataStatus

                visible: root.showStatus

                badgeHeight: root.effectiveBadgeHeight
                textSize: root.effectiveBadgeTextSize

                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
