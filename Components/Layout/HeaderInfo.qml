import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property string title: ""
    property string value: ""
    property color valueColor: "#F2F7FC"

    implicitWidth: 130
    implicitHeight: 44

    ColumnLayout {
        anchors.fill: parent
        spacing: 3

        Text {
            text: root.title
            color: "#9AB6C8"
            font.pixelSize: 11
        }

        Text {
            text: root.value
            color: root.valueColor
            font.pixelSize: 14
            font.bold: true
            elide: Text.ElideRight
            Layout.fillWidth: true
        }
    }
}