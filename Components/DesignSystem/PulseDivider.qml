import QtQuick

Rectangle {
    id: root

    property bool vertical: false
    property color dividerColor: "#16435A"

    implicitWidth: vertical ? 1 : 100
    implicitHeight: vertical ? 100 : 1

    color: dividerColor
    radius: 1
}
