import QtQuick

Text {
    id: root

    property color labelColor: "#9AB6C8"
    property int labelSize: 15
    property bool emphasized: false

    text: ""
    color: labelColor
    font.pixelSize: labelSize
    font.bold: emphasized
    font.family: "Segoe UI"

    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter
}