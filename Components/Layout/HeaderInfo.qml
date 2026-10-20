import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

Item {
    id: root

    PulseTheme {
        id: theme
    }

    // Header information
    property string title: ""
    property string value: ""

    // Colors
    property color titleColor: theme.headerInfoTitleColor
    property color valueColor: theme.headerInfoValueColor

    // Typography
    property string fontFamily: theme.fontFamily
    property int titleSize: theme.headerInfoTitleSize
    property int valueSize: theme.headerInfoValueSize

    // Geometry
    property int contentWidth: theme.headerInfoWidth
    property int contentHeight: theme.headerInfoHeight
    property int contentSpacing: theme.headerInfoSpacing

    implicitWidth: root.contentWidth
    implicitHeight: root.contentHeight

    ColumnLayout {
        id: contentLayout
        anchors.fill: parent
        spacing: root.contentSpacing

        PulseLabel {
            id: titleLabel
            text: root.title
            labelColor: root.titleColor
            labelSize: root.titleSize
            fontFamily: root.fontFamily
            Layout.fillWidth: true
        }

        PulseLabel {
            id: valueLabel
            text: root.value
            labelColor: root.valueColor
            labelSize: root.valueSize
            fontFamily: root.fontFamily
            emphasized: true
            Layout.fillWidth: true
        }
    }
}
