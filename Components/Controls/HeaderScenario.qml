import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

ColumnLayout {
    id: root

    PulseTheme {
        id: theme
    }

    // Scenario information
    property string title: theme.scenarioTitle
    property string scenarioName: theme.defaultScenarioName

    // Scenario names
    property string normalScenario: theme.normalScenarioName
    property string warningScenario: theme.warningScenarioName
    property string criticalScenario: theme.criticalScenarioName

    // Icon configuration
    property string indicatorIcon: theme.scenarioIndicatorIcon

    // Typography
    property string fontFamily: theme.fontFamily

    property int titleSize: theme.scenarioTitleSize
    property int valueSize: theme.scenarioValueSize

    // Colors
    property color titleColor: theme.textSecondary
    property color textColor: theme.textPrimary
    property color iconColor: theme.cyan

    // Status colors
    property color normalColor: theme.normal
    property color warningColor: theme.warning
    property color criticalColor: theme.critical
    property color defaultColor: theme.textSecondary

    // Surface colors
    property color backgroundColor: theme.surface
    property color hoverColor: theme.surfaceHover
    property color borderColor: theme.border

    // Selector dimensions
    property int selectorHeight: theme.scenarioSelectorHeight
    property int selectorWidth: theme.scenarioSelectorWidth
    property int cornerRadius: theme.scenarioCornerRadius

    // Content geometry
    property int horizontalPadding: theme.scenarioHorizontalPadding
    property int indicatorSize: theme.scenarioIndicatorSize
    property int iconSize: theme.scenarioIconSize

    // Spacing
    property int contentSpacing: theme.scenarioContentSpacing
    property int verticalSpacing: theme.scenarioVerticalSpacing

    // Interaction
    property real disabledOpacity: theme.scenarioDisabledOpacity

    // Derived state
    readonly property string normalizedStatus:
        root.scenarioName.trim().toLowerCase()

    readonly property color scenarioColor: {
        switch (root.normalizedStatus) {
        case root.normalScenario.trim().toLowerCase():
            return root.normalColor

        case root.warningScenario.trim().toLowerCase():
            return root.warningColor

        case root.criticalScenario.trim().toLowerCase():
            return root.criticalColor

        default:
            return root.defaultColor
        }
    }

    signal scenarioRequested()

    spacing: root.verticalSpacing

    PulseLabel {
        id: scenarioTitle
        text: root.title
        labelColor: root.titleColor
        labelSize: root.titleSize
        fontFamily: root.fontFamily
    }

    Rectangle {
        id: selectorBackground
        Layout.preferredWidth: root.selectorWidth
        Layout.preferredHeight: root.selectorHeight

        radius: root.cornerRadius

        color: selectorMouseArea.containsMouse && root.enabled
               ? root.hoverColor : root.backgroundColor

        opacity: root.enabled ? 1.0 : root.disabledOpacity

        border.width: theme.borderThin
        border.color: root.borderColor

        RowLayout {
            anchors.fill: parent

            anchors.leftMargin: root.horizontalPadding
            anchors.rightMargin: root.horizontalPadding

            spacing: root.contentSpacing

            Rectangle {
                id: scenarioIndicator

                implicitWidth: root.indicatorSize
                implicitHeight: root.indicatorSize

                radius: width / 2
                color: root.scenarioColor
            }

            PulseLabel {
                id: scenarioValue

                text: root.scenarioName

                labelColor: root.textColor
                labelSize: root.valueSize
                fontFamily: root.fontFamily

                emphasized: true

                Layout.fillWidth: true
            }

            PulseIcon {
                id: scenarioIcon
                iconName: root.indicatorIcon
                iconColor: root.iconColor
                iconSize: root.iconSize
            }
        }

        MouseArea {
            id: selectorMouseArea
            anchors.fill: parent

            enabled: root.enabled
            hoverEnabled: true

            cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

            onClicked: {
                root.scenarioRequested()
            }
        }
    }
}
