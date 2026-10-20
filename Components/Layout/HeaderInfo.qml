import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property string title: ""
    property string value: ""
    property color valueColor: "#F2F7FC"

    implicitWidth: 150
    implicitHeight: 48

    ColumnLayout {
        anchors.fill: parent
        spacing: 4

        Text {
            text: root.title
            color: "#9AB6C8"
            font.pixelSize: 12
        }

        Text {
            text: root.value
            color: root.valueColor
            font.pixelSize: 15
            font.bold: true
            elide: Text.ElideRight
            Layout.fillWidth: true
        }
    }
}