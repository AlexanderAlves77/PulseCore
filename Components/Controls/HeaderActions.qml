import QtQuick
import QtQuick.Layouts
import "../DesignSystem"

RowLayout {
    id: root

    property string batteryIconName: "battery"
    property string settingsIconName: "settings"
    property string batteryUnit: "%"
    property string fontFamily: "Segoe UI"

    property color normalBatteryColor: "#21F58B"
    property color lowBatteryColor: "#FF405D"
    property color settingsIconColor: "#00DDF2"
    property color dividerColor: "#16435A"

    property int batteryLevel: 100
    property int minimumBatteryLevel: 0
    property int maximumBatteryLevel: 100
    property int lowBatteryLevel: 20
    property int batteryIconSize: 26
    property int batteryTextSize: 13
    property int settingsButtonSize: 40
    property int settingsIconSize: 22
    property int dividerLength: 30
    property int contentSpacing: 12
    property int batterySpacing: 6

    property bool showBattery: true
    property bool showSettings: true
    property bool settingsEnabled: true

    readonly property int displayedBatteryLevel:
        Math.max(
            minimumBatteryLevel,
            Math.min(maximumBatteryLevel, batteryLevel)
        )

    readonly property bool isBatteryLow:
        displayedBatteryLevel <= lowBatteryLevel

    readonly property color batteryColor:
        isBatteryLow ? lowBatteryColor : normalBatteryColor

    signal settingsRequested()

    spacing: contentSpacing

    RowLayout {
        id: batteryContent

        visible: root.showBattery
        spacing: root.batterySpacing

        PulseIcon {
            iconName: root.batteryIconName
            iconColor: root.batteryColor
            iconSize: root.batteryIconSize

            Layout.alignment: Qt.AlignVCenter
        }

        PulseLabel {
            text: root.displayedBatteryLevel + root.batteryUnit

            labelColor: root.batteryColor
            labelSize: root.batteryTextSize
            fontFamily: root.fontFamily
            emphasized: true

            Layout.alignment: Qt.AlignVCenter
        }
    }

    PulseDivider {
        vertical: true
        dividerLength: root.dividerLength
        dividerColor: root.dividerColor

        visible: root.showBattery && root.showSettings

        Layout.alignment: Qt.AlignVCenter
    }

    PulseIconButton {
        iconName: root.settingsIconName
        iconColor: root.settingsIconColor

        buttonSize: root.settingsButtonSize
        iconSize: root.settingsIconSize

        enabled: root.settingsEnabled

        visible: root.showSettings

        Layout.alignment: Qt.AlignVCenter

        onClicked: root.settingsRequested()
    }
}

