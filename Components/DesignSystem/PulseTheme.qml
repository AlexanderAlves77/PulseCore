import QtQuick

QtObject {
    id: root

    // Background colors
    readonly property color background: "#050B12"
    readonly property color surface: "#0B1621"
    readonly property color surfaceElevated: "#101E2B"
    readonly property color border: "#16435A"

    // Typography colors
    readonly property color textPrimary: "#F2F7FC"
    readonly property color textSecondary: "#9AB6C8"
    readonly property color textMuted: "#648398"

    // Monitoring colors
    readonly property color green: "#21F58B"
    readonly property color cyan: "#00DDF2"
    readonly property color red: "#FF405D"
    readonly property color amber: "#FFB020"
    readonly property color yellow: "#FFE34A"

    // Card geometry
    readonly property int cardRadius: 14
    readonly property int cardBorderWidth: 1
    readonly property int cardPadding: 16

    // Card sizes
    readonly property int cardSmallHeight: 96
    readonly property int cardMediumHeight: 136
    readonly property int cardLargeHeight: 300

    // Layout spacing
    readonly property int spacingSmall: 8
    readonly property int spacingMedium: 16
    readonly property int spacingLarge: 24

    // Typography sizes
    readonly property int fontSmall: 12
    readonly property int fontMedium: 15
    readonly property int fontLarge: 20
    readonly property int fontTitle: 28
    readonly property int fontVital: 64
}