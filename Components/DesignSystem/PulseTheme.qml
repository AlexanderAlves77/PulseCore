import QtQuick

QtObject {
    id: root

    // Background colors
    readonly property color background: "#02070C"
    readonly property color surface: "#0B1621"
    readonly property color surfaceElevated: "#101E2B"
    readonly property color surfaceInset: "#07121D"
    readonly property color surfaceHover: "#102D37"
    readonly property color surfacePressed: "#16435A"
    readonly property color border: "#16435A"
    readonly property color transparent: "transparent"

    // Typography colors
    readonly property color textPrimary: "#F2F7FC"
    readonly property color textSecondary: "#9AB6C8"
    readonly property color textMuted: "#648398"
    readonly property color textDisabled: textMuted

    // Monitoring colors
    readonly property color green: "#21F58B"
    readonly property color cyan: "#00DDF2"
    readonly property color red: "#FF405D"
    readonly property color amber: "#FFB020"
    readonly property color yellow: "#FFE34A"

    // Semantic status colors
    readonly property color normal: green
    readonly property color warning: amber
    readonly property color critical: red
    readonly property color paused: yellow
    readonly property color unavailable: textMuted

    // Vital sign colors
    readonly property color heartRateColor: green
    readonly property color oxygenColor: cyan
    readonly property color respiratoryColor: red
    readonly property color co2Color: amber
    readonly property color temperatureColor: yellow

    // Waveform colors
    readonly property color waveformBackground: "#101A27"
    readonly property color waveformGrid: border

    // Interactive button colors
    readonly property color buttonStartBackground: "#273C35"
    readonly property color buttonPauseBackground: "#302B24"
    readonly property color buttonResetBackground: "#30242A"

    readonly property color buttonStartText: green
    readonly property color buttonPauseText: amber
    readonly property color buttonResetText: red

    // Typography
    readonly property string fontFamily: "Segoe UI"

    readonly property int fontTiny: 9
    readonly property int fontCaption: 10
    readonly property int fontLabel: 11
    readonly property int fontSmall: 12
    readonly property int fontBody: 13
    readonly property int fontMedium: 15
    readonly property int fontHeading: 16
    readonly property int fontLarge: 20
    readonly property int fontTitle: 28

    readonly property int fontVitalCompact: 38
    readonly property int fontVital: 64
    readonly property int fontVitalHero: 72

    // Shared geometry
    readonly property int radiusSmall: 5
    readonly property int radiusMedium: 8
    readonly property int radiusLarge: 12

    readonly property int borderThin: 1

    // Padding
    readonly property int paddingSmall: 8
    readonly property int paddingMedium: 12
    readonly property int paddingLarge: 16

    // Spacing
    readonly property int spacingTiny: 3
    readonly property int spacingCompact: 6
    readonly property int spacingSmall: 8
    readonly property int spacingCard: 10
    readonly property int spacingMedium: 16
    readonly property int spacingLarge: 24

    // Card geometry
    readonly property int cardRadius: 14
    readonly property int cardBorderWidth: 1
    readonly property int cardPadding: 16

    // Card sizes
    readonly property int cardSmallHeight: 96
    readonly property int cardMediumHeight: 136
    readonly property int cardLargeHeight: 300

    // Icon sizes
    readonly property int iconSmall: 16
    readonly property int iconMedium: 24
    readonly property int iconLarge: 28
    readonly property int iconMedical: 28

    // Badge geometry
    readonly property int badgeHeight: 26
    readonly property int badgeRadius: 6
    readonly property int badgeHorizontalPadding: 10

    // Divider geometry
    readonly property int dividerThickness: 1
    readonly property int dividerHeaderLength: 38

    // Header - Patient defaults
    readonly property string patientTitle: "Patient"
    readonly property string defaultPatientName: "Adult"
    readonly property string defaultPatientType: "Simulation"
    readonly property string patientIconName: "patient"

    // Header - Scenario defaults
    readonly property string scenarioTitle: "Scenario"
    readonly property string defaultScenarioName: "Normal"
    readonly property string normalScenarioName: "Normal"
    readonly property string warningScenarioName: "Warning"
    readonly property string criticalScenarioName: "Critical"
    readonly property string scenarioIndicatorIcon: "chevron-down"

    // Header - Scenario typography
    readonly property int scenarioTitleSize: fontLabel
    readonly property int scenarioValueSize: fontBody

    // Header - Scenario dimensions
    readonly property int scenarioSelectorWidth: 150
    readonly property int scenarioSelectorHeight: 30
    readonly property int scenarioCornerRadius: 6
    readonly property int scenarioHorizontalPadding: 10
    readonly property int scenarioIndicatorSize: 7
    readonly property int scenarioIconSize: iconSmall

    // Header - Scenario spacing
    readonly property int scenarioContentSpacing: spacingSmall
    readonly property int scenarioVerticalSpacing: 4

    // Header - Scenario interaction
    readonly property real scenarioDisabledOpacity: 0.5

    // Header - Clock defaults
    readonly property string clockTitle: "Date & Time"
    readonly property string clockIconName: "clock"
    readonly property string clockDatePlaceholder: "--/--/----"
    readonly property string clockTimePlaceholder: "--:--:--"
    readonly property string clockDateTimeSeparator: "  "

    // Header - Clock colors
    readonly property color clockTitleColor: textSecondary
    readonly property color clockDateColor: textPrimary
    readonly property color clockTimeColor: cyan
    readonly property color clockIconColor: cyan

    // Header - Clock typography
    readonly property int clockTitleSize: fontLabel
    readonly property int clockValueSize: fontBody

    // Header - Clock geometry
    readonly property int clockIconSize: 26
    readonly property int clockContentSpacing: spacingCard
    readonly property int clockTextSpacing: spacingTiny

    // Header - Clock visibility
    readonly property bool clockShowDate: true
    readonly property bool clockShowTime: true

    // Header - Actions defaults
    readonly property string headerBatteryIconName: "battery"
    readonly property string headerSettingsIconName: "settings"
    readonly property string headerBatteryUnit: "%"

    // Header - Battery configuration
    readonly property int headerBatteryLevel: 100
    readonly property int headerBatteryMinimum: 0
    readonly property int headerBatteryMaximum: 100
    readonly property int headerBatteryLowThreshold: 20

    // Header - Actions colors
    readonly property color headerBatteryNormalColor: green
    readonly property color headerBatteryLowColor: red
    readonly property color headerSettingsIconColor: cyan
    readonly property color headerActionsDividerColor: border

    // Header - Actions dimensions
    readonly property int headerBatteryIconSize: 26
    readonly property int headerBatteryTextSize: fontBody
    readonly property int headerSettingsButtonSize: 40
    readonly property int headerSettingsIconSize: 22
    readonly property int headerActionsDividerLength: 30

    // Header - Actions spacing
    readonly property int headerActionsContentSpacing: 12
    readonly property int headerBatterySpacing: spacingCompact

    // Header - Actions visibility
    readonly property bool headerShowBattery: true
    readonly property bool headerShowSettings: true
    readonly property bool headerSettingsEnabled: true


    // Vital Monitor - Defaults
    readonly property string monitorDefaultTitle: "Oxygen Saturation"
    readonly property string monitorDefaultSubtitle: "SpO2 %"
    readonly property string monitorDefaultIconName: "lungs"
    readonly property string monitorDefaultStatus: "NORMAL"
    readonly property string monitorNoDataStatus: "NO DATA"
    readonly property string monitorTemperatureT1Label: "T1"
    readonly property string monitorTemperatureT2Label: "T2"
    readonly property string monitorTemperatureDeltaLabel: "ΔT"
    readonly property string monitorUnavailableValue: "--"

    // Vital Monitor - Colors
    readonly property color monitorAccentColor: oxygenColor
    readonly property color monitorTitleColor: textPrimary
    readonly property color monitorSecondaryColor: textSecondary
    readonly property color monitorDetailBackgroundColor: surfaceInset

    // Vital Monitor - Typography
    readonly property int monitorTitleSize: fontSmall
    readonly property int monitorCompactTitleSize: fontLabel
    readonly property int monitorSubtitleSize: fontCaption
    readonly property int monitorValueSize: fontVitalCompact
    readonly property int monitorCompactValueSize: 34
    readonly property int monitorUnitSize: fontLabel
    readonly property int monitorScaleSize: fontTiny
    readonly property int monitorDetailTitleSize: fontTiny
    readonly property int monitorDetailValueSize: fontLabel

    // Vital Monitor - Card geometry
    readonly property int monitorCardWidth: 500
    readonly property int monitorCardHeight: 72
    readonly property int monitorCompactThreshold: 76
    readonly property int monitorCompactPadding: paddingSmall
    readonly property int monitorRegularPadding: spacingCard
    readonly property int monitorContentSpacing: spacingSmall

    // Vital Monitor - Icon
    readonly property int monitorIconSize: iconMedical
    readonly property int monitorCompactIconSize: 25

    // Vital Monitor - Columns
    readonly property int monitorTitleWidth: 125
    readonly property int monitorTitleMinimumWidth: 95
    readonly property int monitorValueWidth: 85
    readonly property int monitorValueMinimumWidth: 65
    readonly property int monitorDetailWidth: 84
    readonly property int monitorDetailMinimumWidth: 75
    readonly property int monitorTemperatureWidth: 120
    readonly property int monitorTemperatureMinimumWidth: 105

    // Vital Monitor - Scale
    readonly property real monitorScaleMinimum: 85
    readonly property real monitorScaleMaximum: 100
    readonly property int monitorScaleBarWidth: 3
    readonly property int monitorScaleBarHeight: 36
    readonly property int monitorCompactScaleBarHeight: 28
    readonly property int monitorScaleSpacing: 5

    // Vital Monitor - Details
    readonly property int monitorDetailHeight: 34
    readonly property int monitorCompactDetailHeight: 27
    readonly property int monitorDetailRadius: radiusSmall
    readonly property int monitorDetailPadding: spacingTiny
    readonly property int monitorDetailSpacing: 4
    readonly property int monitorCompactDetailSpacing: 2
    readonly property int monitorTemperatureSpacing: 7

    // Vital Monitor - Signal indicator
    readonly property int monitorSignalMaximum: 4
    readonly property int monitorSignalBarWidth: 4
    readonly property int monitorSignalBarSpacing: spacingTiny
    readonly property int monitorSignalBarRadius: 2
    readonly property int monitorSignalBarHeight1: 7
    readonly property int monitorSignalBarHeight2: 11
    readonly property int monitorSignalBarHeight3: 15
    readonly property int monitorSignalBarHeight4: 19

    // Layout - AppHeader defaults
    readonly property string appHeaderPatientName: defaultPatientName
    readonly property string appHeaderScenarioName: defaultScenarioName
    readonly property string appHeaderSimulationTime: "00:00:00"
    readonly property string appHeaderSimulationLabel: "Simulation"

    // Layout - AppHeader colors
    readonly property color appHeaderBackground: surfaceInset
    readonly property color appHeaderTitleColor: textPrimary
    readonly property color appHeaderSecondaryColor: textSecondary
    readonly property color appHeaderAccentColor: cyan
    readonly property color appHeaderBorderColor: border

    // Layout - AppHeader geometry
    readonly property int appHeaderHeight: 76
    readonly property int appHeaderHorizontalPadding: spacingLarge
    readonly property int appHeaderComponentSpacing: spacingMedium
    readonly property int appHeaderDividerHeight: dividerHeaderLength

    // Layout - AppHeader component widths
    readonly property int appHeaderBrandMinimumWidth: 230
    readonly property int appHeaderPatientWidth: 135
    readonly property int appHeaderScenarioWidth: 155
    readonly property int appHeaderClockWidth: 195

    // Layout - AppHeader clock
    readonly property int appHeaderClockIconSize: 23
    readonly property int appHeaderClockValueSize: fontSmall
    readonly property int appHeaderClockSpacing: 7
    readonly property int appHeaderClockColumnSpacing: spacingTiny

    // Layout - AppHeader simulation
    readonly property int appHeaderSimulationLeftMargin: 30
    readonly property int appHeaderSimulationSpacing: spacingCompact
    readonly property int appHeaderSimulationLabelSize: fontCaption
    readonly property int appHeaderSimulationValueSize: fontLabel

    // Layout - AppHeader actions
    readonly property int appHeaderBatteryIconSize: iconLarge
    readonly property int appHeaderBatteryTextSize: fontBody
    readonly property int appHeaderBatterySpacing: spacingCompact
    readonly property int appHeaderSettingsButtonSize: 42
    readonly property int appHeaderSettingsIconSize: 25
    readonly property int appHeaderActionsSpacing: 12

    // Layout - AppHeader timing
    readonly property int appHeaderClockInterval: 1000
    readonly property string appHeaderDateFormat: "dd/MM/yyyy"
    readonly property string appHeaderTimeFormat: "HH:mm:ss"

    // Layout - HeaderInfo colors
    readonly property color headerInfoTitleColor: textSecondary
    readonly property color headerInfoValueColor: textPrimary

    // Layout - HeaderInfo typography
    readonly property int headerInfoTitleSize: fontLabel
    readonly property int headerInfoValueSize: 14

    // Layout - HeaderInfo geometry
    readonly property int headerInfoWidth: 130
    readonly property int headerInfoHeight: 44
    readonly property int headerInfoSpacing: spacingTiny

    // Layout - DashboardPanel colors
    readonly property color dashboardBackgroundColor: "#0B111B"
    readonly property color dashboardSurfaceColor: "#141F2E"
    readonly property color dashboardBorderColor: "#263548"

    // Layout - DashboardPanel geometry
    readonly property int dashboardContentMargin: 4
    readonly property int dashboardPanelPadding: 0
    readonly property int dashboardCornerRadius: 0
    readonly property int dashboardBorderWidth: 0

    // Layout - DashboardPanel behavior
    readonly property bool dashboardClipContent: true

    // Layout - AppFooter content
    readonly property string appFooterDisclaimerText: "SIMULATION ONLY — NOT FOR CLINICAL USE"

    // Layout - AppFooter colors
    readonly property color appFooterBackgroundColor: dashboardSurfaceColor
    readonly property color appFooterWarningColor: "#F0B75E"

    // Layout - AppFooter typography
    readonly property int appFooterFontSize: fontBody
    readonly property bool appFooterFontBold: true

    // Layout - AppFooter geometry
    readonly property int appFooterHeight: 60
    readonly property int appFooterHorizontalPadding: paddingLarge
    readonly property int appFooterVerticalPadding: paddingSmall    

    // Monitoring - Right panel geometry
    readonly property int rightPanelPreferredWidth: 500
    readonly property int rightPanelPreferredHeight: 620

    readonly property int rightPanelSpacing: spacingCard
    readonly property int rightPanelVitalCardSpacing: spacingSmall

    readonly property real rightPanelHeartRatio: 0.39
    readonly property int rightPanelHeartMinimumHeight: 170
    readonly property int rightPanelVitalMinimumHeight: 64
    readonly property int rightPanelVitalCardCount: 4
}