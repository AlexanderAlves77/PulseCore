import QtQuick
import QtQuick.Layouts


RowLayout {
    id: root

    PulseTheme {
        id: theme
    }

    // Data
    property real value: 0
    property int decimals: 0
    property string unit: ""

    // Appearance
    property color valueColor: theme.textPrimary
    property color unitColor: theme.textSecondary

    // Typography
    property int valueSize: theme.fontVital
    property int unitSize: 14
    property string fontFamily: theme.fontFamily

    // Layout
    property int numberSpacing: theme.spacingCompact

    // State
    property bool emphasized: true
    property bool hasData: false

    spacing: numberSpacing

    PulseLabel {
        id: valueLabel

        text: root.hasData ? Number(root.value).toFixed(root.decimals) : "--"
        labelColor: root.valueColor
        labelSize: root.valueSize
        fontFamily: root.fontFamily
        emphasized: root.emphasized

        Layout.alignment: Qt.AlignBaseline
    }

    PulseLabel {
        id: unitLabel

        text: root.unit
        labelColor: root.unitColor
        labelSize: root.unitSize
        fontFamily: root.fontFamily

        visible: root.unit.length > 0
        Layout.alignment: Qt.AlignBaseline        
    }
}