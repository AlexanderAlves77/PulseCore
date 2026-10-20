import QtQuick

Rectangle {
    id: root

    property color dividerColor: "#16435A"
    property int dividerThickness: 1
    property int dividerLength: 32

    property bool vertical: true
    property real dividerOpacity: 1.0

    implicitWidth: vertical ? dividerThickness : dividerLength
    implicitHeight: vertical ? dividerLength : dividerThickness

    color: dividerColor
    opacity: dividerOpacity
}
