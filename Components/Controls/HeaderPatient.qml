import QtQuick
import QtQuick.Layouts
import "../DesignSystem"

RowLayout {
    id: root

    property string title: "Patient"
    property string patientName: "Adult"
    property string patientType: "Simulation"
    property string iconName: "patient"
    property string separator: " · "
    property string fontFamily: "Segoe UI"

    property color titleColor: "#9AB6C8"
    property color valueColor: "#F2F7FC"
    property color typeColor: "#9AB6C8"
    property color iconColor: "#00DDF2"

    property int iconSize: 26
    property int titleSize: 11
    property int valueSize: 14
    property int contentSpacing: 10
    property int textSpacing: 3

    spacing: contentSpacing

    PulseIcon {
        iconName: root.iconName
        iconColor: root.accentColor
        iconSize: root.iconSize

        Layout.alignment: Qt.AlignVCenter
    }

    ColumnLayout {
        spacing: root.textSpacing

        PulseLabel {
            text: root.title
            labelColor: root.titleColor
            labelSize: root.titleSize
            fontFamily: root.fontFamily
        }

        RowLayout {
            spacing: 0

            PulseLabel {
                text: root.primaryName
                labelColor: root.valueColor
                labelSize: root.valueSize
                fontFamily: root.fontFamily
                emphasized: true
            }

            PulseLabel {
                text: root.separator + root.patientType
                labelColor: root.typeColor
                labelSize: root.valueSize
                fontFamily: root.fontFamily
                visible: root.patientType.length > 0
            }
        }
    }
}
