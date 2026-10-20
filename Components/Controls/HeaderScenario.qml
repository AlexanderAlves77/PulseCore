import QtQuick
import QtQuick.Layouts
import "../DesignSystem"

ColumnLayout {
    id: root

    property string title: "Scenario"
    property string scenarioName: "Normal"
    property string normalScenario: "Normal"
    property string warningScenario: "Warning"
    property string criticalScenario: "Critical"
    property string indicatorIcon: "chevron-down"
    property string fontFamily: "Segoe UI"

    property color titleColor: "#9AB6C8"
    property color textColor: "#F2F7FC"
    property color iconColor: "#00DDF2"
    property color normalColor: "#21F58B"
    property color warningColor: "#FFB020"
    property color criticalColor: "#FF405D"
    property color defaultColor: "#9AB6C8"
    property color backgroundColor: "#0B1621"
    property color hoverColor: "#102D37"
    property color borderColor: "#16435A"

    property int titleSize: 11
    property int valueSize: 13
    property int selectorHeight: 30
    property int selectorWidth: 150
    property int cornerRadius: 6
    property int horizontalPadding: 10
    property int indicatorSize: 7
    property int iconSize: 16
    property int contentSpacing: 8
    property int verticalSpacing: 4

    property bool enabled: true

    readonly property string normalizedStatus: scenarioName.trim().toUpperCase()

    readonly property color scenarioColor:
    {
        switch (normalizedStatus)
        {
        case normalScenario.toLowerCase():
            return normalColor

        case warningScenario.toLowerCase():
            return warningColor

        case criticalScenario.toLowerCase():
            return criticalColor

        default:
            return defaultColor
        }
    }

    signal scenarioRequested()

    spacing: verticalSpacing

    PulseLabel {
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

        border.width: 1
        border.color: root.borderColor

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: root.horizontalPadding
            anchors.rightMargin: root.horizontalPadding

            spacing: root.contentSpacing

            Rectangle {
                implicitWidth: root.indicatorSize
                implicitHeight: root.indicatorSize

                radius: root.indicatorSize / 2
                color: root.scenarioColor
            }

            PulseLabel {
                text: root.scenarioName
                labelColor: root.textColor
                labelSize: root.valueSize
                fontFamily: root.fontFamily
                emphasized: true

                Layout.fillWidth: true
            }

            PulseIcon {
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
            cursorShape: Qt.PointingHandCursor

            onClicked: root.scenarioRequested()
        }
    }
}
