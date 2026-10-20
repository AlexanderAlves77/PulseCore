import QtQuick
import QtQuick.Layouts
import "../../DesignSystem"

RowLayout {
    id: root

    property string primaryName: "Pulse"
    property string accentName: "Core"
    property string iconName: "ecg"
    property string fontFamily: "Segoe UI"
    property string description: "MEDICAL DEVICE MONITORING SIMULATOR"

    property color primaryColor: "#F2F7FC"
    property color accentColor: "#00DDF2"
    property color descriptionColor: "#9AB6C8"

    property int iconSize: 40
    property int titleSize: 24
    property int descriptionSize: 10
    property int contentSpacing: 12
    property int textSpacing: 2

    spacing: contentSpacing

    PulseIcon {
        iconName: root.iconName
        iconColor: root.accentColor
        iconSize: root.iconSize
    }

    ColumnLayout {
        spacing: root.textSpacing

        RowLayout {
            spacing: 0

            PulseLabel {
                text: root.primaryName
                labelColor: root.primaryColor
                labelSize: root.titleSize
                fontFamily: root.fontFamily
                emphasized: true
            }

            PulseLabel {
                text: root.accentName
                labelColor: root.accentColor
                labelSize: root.titleSize
                fontFamily: root.fontFamily
                emphasized: true
            }
        }

        PulseLabel {
            text: root.description
            labelColor: root.descriptionColor
            labelSize: root.descriptionSize
            fontFamily: root.fontFamily
            Layout.fillWidth: true
        }
    }
}
