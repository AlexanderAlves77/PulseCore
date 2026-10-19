
import QtQuick

Rectangle {
    id: root
    color: root.backgroundColor

    property color backgroundColor: "#0B111B"
    property color surfaceColor: "#141F2E"
    property color borderColor: "#263548"
    property int contentMargin: 24
    property int panelPadding: 20

    default property alias content: dashboardContent.data

    Rectangle {
        id: monitorPanel
        anchors.fill: parent
        anchors.margins: root.contentMargin
        color: root.surfaceColor
        border.color: root.borderColor
        border.width: 1
        radius: 12

        Item {
            id: dashboardContent
            anchors.fill: parent
            anchors.margins: root.panelPadding
        }
    }
}

