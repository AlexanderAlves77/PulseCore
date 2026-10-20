import QtQuick

Rectangle {
    id: root

    PulseTheme {
        id: theme
    }

    // Appearance
    property color dividerColor: theme.border
    property int dividerThickness: theme.dividerThickness
    property real dividerOpacity: 1.0

    // Dimensions
    property int dividerLength: 32

    // Orientation
    property bool vertical: true

    implicitWidth: root.vertical ? root.dividerThickness : root.dividerLength
    implicitHeight: root.vertical ? root.dividerLength : root.dividerThickness

    color: root.dividerColor
    opacity: root.dividerOpacity
}
