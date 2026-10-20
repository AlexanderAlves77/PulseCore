import QtQuick
import QtQuick.Layouts
import "../DesignSystem"

RowLayout {
    id: root

    property string title: "Date & Time"
    property string iconName: "clock"
    property string fontFamily: "Segoe UI"
    property string dateTimeSeparator: "  "
    property string dateText: "--/--/----"
    property string timeText: "--:--:--"

    property color titleColor: "#9AB6C8"
    property color dateColor: "#F2F7FC"
    property color timeColor: "#00DDF2"
    property color iconColor: "#00DDF2"

    property int iconSize: 26
    property int titleSize: 11
    property int valueSize: 13
    property int contentSpacing: 10
    property int textSpacing: 3

    property bool showDate: true
    property bool showTime: true

    spacing: contentSpacing

    PulseIcon {
        iconName: root.iconName
        iconColor: root.iconColor
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
                text: root.dateText
                labelColor: root.dateColor
                labelSize: root.valueSize
                fontFamily: root.fontFamily

                visible: root.showDate
            }

            PulseLabel {
                text: root.dateTimeSeparator
                labelColor: root.titleColor
                labelSize: root.valueSize
                fontFamily: root.fontFamily

                visible: root.showDate && root.showTime
            }

            PulseLabel {
                text: root.timeText
                labelColor: root.timeColor
                labelSize: root.valueSize
                fontFamily: root.fontFamily
                emphasized: true

                visible: root.showTime
            }
        }
    }
}
