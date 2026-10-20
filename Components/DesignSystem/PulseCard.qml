import QtQuick

Rectangle {
    id: root

    PulseTheme {
        id: theme
    }

    // Appearance
    property color cardColor: theme.surface
    property color borderColor: theme.border

    property int borderThickness: theme.cardBorderWidth
    property int cornerRadius: theme.cardRadius
    property int contentPadding: theme.cardPadding

    // Dimensions
    property int preferredWidth: 320
    property int preferredHeight: theme.cardMediumHeight

    property bool outlined: true

    default property alias content: contentContainer.data

    implicitWidth: root.preferredWidth
    implicitHeight: root.preferredHeight

    radius: root.cornerRadius
    color: root.cardColor

    border.color: root.borderColor
    border.width: root.outlined ? root.borderThickness : 0

    Item {
        id: contentContainer

        anchors.fill: parent
        anchors.margins: root.contentPadding
    }
}