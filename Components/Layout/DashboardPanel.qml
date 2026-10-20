import QtQuick

Rectangle {
    id: root

    property color backgroundColor: "#0B111B"
    property color surfaceColor: "#141F2E"
    property color borderColor: "#263548"

    property int contentMargin: 4
    property int panelPadding: 0
    property int cornerRadius: 0

    default property alias content: dashboardContent.data

    color: root.backgroundColor
    border.width: 0

    Rectangle {
        id: monitorPanel
        anchors.fill: parent
        anchors.margins: root.contentMargin
        color: root.surfaceColor
        radius: root.cornerRadius
        border.width: 0

        Item {
            id: dashboardContent
            anchors.fill: parent
            anchors.margins: root.panelPadding
            clip: true
        }
    }
}

