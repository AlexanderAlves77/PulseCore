import QtQuick

QtObject {
    id: root

    property real value: 0

    property real minimumCritical: 40
    property real minimumNormal: 60
    property real maximumNormal: 100
    property real maximumCritical: 140

    readonly property string status: {
        if (value < minimumCritical || value > maximumCritical)
            return "CRITICAL"

        if (value < minimumNormal || value > maximumNormal)
            return "WARNING"

        return "NORMAL"
    }

    readonly property color statusColor: {
        switch (status) {
        case "CRITICAL":
            return "#FF405D"
        case "WARNING":
            return "#FFB020"
        default:
            return "#21F58B"
        }
    }
}