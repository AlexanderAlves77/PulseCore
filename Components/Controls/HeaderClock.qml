import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

RowLayout {
    id: root

    PulseTheme {
        id: theme
    }

    // Clock information
    property string title: theme.clockTitle
    property string iconName: theme.clockIconName

    property string dateText: theme.clockDatePlaceholder
    property string timeText: theme.clockTimePlaceholder
    property string dateTimeSeparator: theme.clockDateTimeSeparator

    // Typography
    property string fontFamily: theme.fontFamily

    property int titleSize: theme.clockTitleSize
    property int valueSize: theme.clockValueSize

    // Colors
    property color titleColor: theme.clockTitleColor
    property color dateColor: theme.clockDateColor
    property color timeColor: theme.clockTimeColor
    property color iconColor: theme.clockIconColor

    // Icon
    property int iconSize: theme.clockIconSize

    // Layout
    property int contentSpacing: theme.clockContentSpacing
    property int textSpacing: theme.clockTextSpacing

    // Visibility
    property bool showDate: theme.clockShowDate
    property bool showTime: theme.clockShowTime

    spacing: root.contentSpacing

    PulseIcon {
        id: clockIcon
        iconName: root.iconName
        iconColor: root.iconColor
        iconSize: root.iconSize
        Layout.alignment: Qt.AlignVCenter
    }

    ColumnLayout {
        id: clockContent
        spacing: root.textSpacing

        PulseLabel {
            id: clockTitle
            text: root.title
            labelColor: root.titleColor
            labelSize: root.titleSize
            fontFamily: root.fontFamily
        }

        RowLayout {
            id: clockValues
            spacing: 0

            PulseLabel {
                id: dateLabel
                text: root.dateText
                labelColor: root.dateColor
                labelSize: root.valueSize
                fontFamily: root.fontFamily

                visible: root.showDate
            }

            PulseLabel {
                id: separatorLabel
                text: root.dateTimeSeparator
                labelColor: root.titleColor
                labelSize: root.valueSize
                fontFamily: root.fontFamily
                visible: root.showDate && root.showTime
            }

            PulseLabel {
                id: timeLabel
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
