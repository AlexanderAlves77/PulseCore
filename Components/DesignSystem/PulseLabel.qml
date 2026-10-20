import QtQuick

Text {
    id: root

    PulseTheme {
        id: theme
    }

    // Appearance
    property color labelColor: theme.textPrimary
    property color mutedColor: theme.textSecondary

    // Typography
    property int labelSize: 14
    property string fontFamily: theme.fontFamily

    // States
    property bool emphasized: false
    property bool muted: false

    color: root.muted ? root.mutedColor : root.labelColor

    font.family: root.fontFamily
    font.pixelSize: root.labelSize
    font.bold: root.emphasized

    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter
}