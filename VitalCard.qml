import QtQuick

Rectangle {
    id: vitalCard
    radius: 12
    color: "#141F2E"

    property string label: ""
    property string value: ""
    property string unit: ""
    property color accentColor: "#40DCA5"

    implicitWidth: 220
    implicitHeight: 145

    border.color: "#263548"
    border.width: 1

    Column {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 12

        Text {
            text: vitalCard.label
            color: "#91A3B8"
            font.pixelSize: 15
            font.bold: true
        }

        Row {
            spacing: 8

            Text {
                text: vitalCard.value
                color: vitalCard.accentColor
                font.pixelSize: 44
                font.bold: true
            }

            Text {
                text: vitalCard.unit
                color: "#91A3B8"
                font.pixelSize: 14
                anchors.baseline: parent.children[0].baseline
            }
        }
    }
}
