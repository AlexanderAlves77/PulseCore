import QtQuick
import QtQuick.Layouts

import "../DesignSystem"

PulseCard {
    id: root

    property string title: ""
    property real value: 0
    property string unit: ""
    property int decimals: 0

    property color accentColor: "#21F58B"

    cardSize: "SMALL"

    ColumnLayout {
        anchors.fill: parent
        spacing: 4

        PulseLabel {
            text: root.title
            labelSize: 13
            emphasized: true
            labelColor: root.accentColor
        }

        PulseNumber {
            value: root.value
            decimals: root.decimals
            unit: root.unit
            valueSize: 38
            unitSize: 12
            valueColor: root.accentColor
        }
    }
}
