import QtQuick

import "../DesignSystem"

Rectangle {
    id: root

    PulseTheme {
        id: theme
    }

    // Dashboard colors
    property color backgroundColor: theme.dashboardBackgroundColor
    property color surfaceColor: theme.dashboardSurfaceColor
    property color borderColor: theme.dashboardBorderColor

    // Dashboard geometry
    property int contentMargin: theme.dashboardContentMargin
    property int panelPadding: theme.dashboardPanelPadding
    property int cornerRadius: theme.dashboardCornerRadius
    property int borderThickness: theme.dashboardBorderWidth

    // Dashboard behavior
    property bool clipContent: theme.dashboardClipContent

    // Public content container
    default property alias content: dashboardContent.data

    color: root.backgroundColor

    border.width: 0

    // Main monitoring surface
    Rectangle {
        id: monitorPanel

        anchors.fill: parent
        anchors.margins: root.contentMargin

        color: root.surfaceColor
        radius: root.cornerRadius

        border.width: root.borderThickness
        border.color: root.borderColor

        // Dashboard content area
        Item {
            id: dashboardContent

            anchors.fill: parent
            anchors.margins: root.panelPadding

            clip: root.clipContent
        }
    }
}
