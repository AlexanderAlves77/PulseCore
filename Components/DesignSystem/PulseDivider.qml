import QtQuick

Rectangle {
    id: root

    property color dividerColor: "#16435A"
    property int dividerThickness: 1

    color: dividerColor

    implicitWidth: dividerThickness
    implicitHeight: 32
}
