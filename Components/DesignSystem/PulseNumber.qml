import QtQuick

Row {
    id: root

    property real value: 0
    property int decimals: 0
    property string unit: ""
    property color valueColor: "#21F58B"
    property color unitColor: "#9AB6C8"
    property int valueSize: 64
    property int unitSize: 16

    spacing: 8

    Text {
        id: numberText

        text: Number(root.value).toFixed(root.decimals)
        color: root.valueColor

        font.family: "Segoe UI"
        font.pixelSize: root.valueSize
        font.bold: true

        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: unitText

        text: root.unit
        visible: root.unit.length > 0
        color: root.unitColor

        font.family: "Segoe UI"
        font.pixelSize: root.unitSize

        anchors.baseline: numberText.baseline
    }
}