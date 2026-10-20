import QtQuick

Text {
    id: root

    property color labelColor: "#F2F7FC"
    property color mutedColor: "#9AB6C8"
    property int labelSize: 14
    property string fontFamily: "Segoe UI"
    property bool emphasized: false
    property bool muted: false

    color: muted ? mutedColor : labelColor
    font.pixelSize: labelSize
    font.bold: emphasized
    font.family: fontFamily
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter
}