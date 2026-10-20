import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

RowLayout {
    id: root

    PulseTheme {
        id: theme
    }

    // Icon configuration
    property string batteryIconName: theme.headerBatteryIconName
    property string settingsIconName: theme.headerSettingsIconName
    property string batteryUnit: theme.headerBatteryUnit

    // Typography
    property string fontFamily: theme.fontFamily

    // Colors
    property color normalBatteryColor: theme.headerBatteryNormalColor
    property color lowBatteryColor: theme.headerBatteryLowColor
    property color settingsIconColor: theme.headerSettingsIconColor
    property color dividerColor: theme.headerActionsDividerColor

    // Battery configuration
    property int batteryLevel: theme.headerBatteryLevel
    property int minimumBatteryLevel: theme.headerBatteryMinimum
    property int maximumBatteryLevel: theme.headerBatteryMaximum
    property int lowBatteryLevel: theme.headerBatteryLowThreshold

    // Dimensions
    property int batteryIconSize: theme.headerBatteryIconSize
    property int batteryTextSize: theme.headerBatteryTextSize
    property int settingsButtonSize: theme.headerSettingsButtonSize
    property int settingsIconSize: theme.headerSettingsIconSize
    property int dividerLength: theme.headerActionsDividerLength

    // Spacing
    property int contentSpacing: theme.headerActionsContentSpacing
    property int batterySpacing: theme.headerBatterySpacing

    // Visibility and interaction
    property bool showBattery: theme.headerShowBattery
    property bool showSettings: theme.headerShowSettings
    property bool settingsEnabled: theme.headerSettingsEnabled

    // Derived battery state
    readonly property int displayedBatteryLevel:
        Math.max(
            root.minimumBatteryLevel,
            Math.min(root.maximumBatteryLevel, root.batteryLevel)
        )

    readonly property bool isBatteryLow: root.displayedBatteryLevel <= root.lowBatteryLevel

    readonly property color batteryColor: root.isBatteryLow ?
        root.lowBatteryColor : root.normalBatteryColor

    signal settingsRequested()

    spacing: root.contentSpacing

    // Battery information
    RowLayout {
        id: batteryContent
        visible: root.showBattery
        spacing: root.batterySpacing

        PulseIcon {
            id: batteryIcon
            iconName: root.batteryIconName
            iconColor: root.batteryColor
            iconSize: root.batteryIconSize
            Layout.alignment: Qt.AlignVCenter
        }

        PulseLabel {
            id: batteryLabel
            text: root.displayedBatteryLevel + root.batteryUnit
            labelColor: root.batteryColor
            labelSize: root.batteryTextSize
            fontFamily: root.fontFamily
            emphasized: true
            Layout.alignment: Qt.AlignVCenter
        }
    }

    // Separator
    PulseDivider {
        id: actionsDivider
        vertical: true
        dividerLength: root.dividerLength
        dividerColor: root.dividerColor
        dividerThickness: theme.dividerThickness
        visible: root.showBattery && root.showSettings
        Layout.alignment: Qt.AlignVCenter
    }

    // Settings action
    PulseIconButton {
        id: settingsButton

        iconName: root.settingsIconName
        iconColor: root.settingsIconColor

        buttonSize: root.settingsButtonSize
        iconSize: root.settingsIconSize

        enabled: root.settingsEnabled
        visible: root.showSettings

        Layout.alignment: Qt.AlignVCenter

        onClicked: {
            root.settingsRequested()
        }
    }
}
