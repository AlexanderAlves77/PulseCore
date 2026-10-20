import QtQuick
import QtQuick.Layouts


RowLayout {
    id: root

    property real value: 0
    property int decimals: 0
    property string unit: ""

    property color valueColor: "#F2F7FC"
    property color unitColor: "#9AB6C8"

    property int valueSize: 64
    property int unitSize: 14
    property int numberSpacing: 6

    property string fontFamily: "Segoe UI"
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

        Layout.alignment: Qt.AlignBaseline
        visible: root.unit.length > 0
    }
}