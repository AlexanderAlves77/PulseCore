import QtQuick

QtObject {
    id: root

    // Background colors
    readonly property color background: "#02070C"
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

    // Semantic surfaces
    readonly property color surfaceInset: "#07121D"
    readonly property color surfaceHover: "#102D37"
    readonly property color surfacePressed: "#16435A"
    readonly property color waveformBackground: "#101A27"
    readonly property color waveformGrid: "#16435A"
    readonly property color transparent: "transparent"

    // Semantic foreground and status colors
    readonly property color textDisabled: textMuted
    readonly property color normal: green
    readonly property color warning: amber
    readonly property color critical: red
    readonly property color paused: yellow
    readonly property color unavailable: textMuted
    readonly property color heartRateColor: green
    readonly property color oxygenColor: cyan
    readonly property color respiratoryColor: red
    readonly property color co2Color: amber
    readonly property color temperatureColor: yellow

    // Interactive elements
    readonly property color buttonStartBackground: "#273C35"
    readonly property color buttonPauseBackground: "#302B24"
    readonly property color buttonResetBackground: "#30242A"
    readonly property color buttonStartText: green
    readonly property color buttonPauseText: amber
    readonly property color buttonResetText: red

    // Header - Patient defaults
    readonly property string patientTitle: "Patient"
    readonly property string defaultPatientName: "Adult"
    readonly property string defaultPatientType: "Simulation"
    readonly property string patientIconName: "patient"

    // Typography family and compact scale
    readonly property string fontFamily: "Segoe UI"
    readonly property int fontTiny: 9
    readonly property int fontCaption: 10
    readonly property int fontLabel: 11
    readonly property int fontBody: 13
    readonly property int fontHeading: 16
    readonly property int fontVitalCompact: 38
    readonly property int fontVitalHero: 72

    // Shared geometry
    readonly property int radiusSmall: 5
    readonly property int radiusMedium: 8
    readonly property int radiusLarge: 12
    readonly property int borderThin: 1
    readonly property int paddingSmall: 8
    readonly property int paddingMedium: 12
    readonly property int paddingLarge: 16
    readonly property int spacingTiny: 3
    readonly property int spacingCompact: 6
    readonly property int spacingCard: 10

    // Icons, badges and dividers
    readonly property int iconSmall: 16
    readonly property int iconMedium: 24
    readonly property int iconLarge: 28
    readonly property int iconMedical: 28
    readonly property int badgeHeight: 26
    readonly property int badgeRadius: 6
    readonly property int badgeHorizontalPadding: 10
    readonly property int dividerThickness: 1
    readonly property int dividerHeaderLength: 38
}