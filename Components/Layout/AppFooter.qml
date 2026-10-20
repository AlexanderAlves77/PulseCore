import QtQuick

import "../DesignSystem"

Rectangle {
    id: root

    PulseTheme {
        id: theme
    }

    // Footer content
    property string disclaimerText: theme.appFooterDisclaimerText

    // Colors
    property color surfaceColor: theme.appFooterBackgroundColor
    property color warningColor: theme.appFooterWarningColor

    // Typography
    property string fontFamily: theme.fontFamily
    property int fontSize: theme.appFooterFontSize
    property bool fontBold: theme.appFooterFontBold

    // Geometry
    property int footerHeight: theme.appFooterHeight
    property int horizontalPadding: theme.appFooterHorizontalPadding
    property int verticalPadding: theme.appFooterVerticalPadding

    implicitHeight: root.footerHeight
    color: root.surfaceColor

    Text {
        id: disclaimerLabel

        anchors.fill: parent
        anchors.leftMargin: root.horizontalPadding
        anchors.rightMargin: root.horizontalPadding
        anchors.topMargin: root.verticalPadding
        anchors.bottomMargin: root.verticalPadding

        text: root.disclaimerText
        color: root.warningColor

        font.family: root.fontFamily
        font.pixelSize: root.fontSize
        font.bold: root.fontBold

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        wrapMode: Text.WordWrap
    }
}
