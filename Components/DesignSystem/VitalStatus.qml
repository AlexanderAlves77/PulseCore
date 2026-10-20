import QtQuick

QtObject {
    id: root

    // Theme
    property PulseTheme theme: PulseTheme {}

    // Vital sign data
    property bool hasData: false
    property real value: 0

    // Classification thresholds
    property real minimumCritical: 40
    property real minimumNormal: 60
    property real maximumNormal: 100
    property real maximumCritical: 140

    // Status appearance
    property color normalColor: theme.normal
    property color warningColor: theme.warning
    property color criticalColor: theme.critical
    property color unavailableColor: theme.unavailable

    // Derived status
    readonly property string status: {
        if (!root.hasData)
            return "NO DATA"

        if (root.value < root.minimumCritical
                || root.value > root.maximumCritical) {
            return "CRITICAL"
        }

        if (root.value < root.minimumNormal
                || root.value > root.maximumNormal) {
            return "WARNING"
        }

        return "NORMAL"
    }

    // Derived appearance
    readonly property color statusColor: {
        switch (root.status) {
        case "NORMAL":
            return root.normalColor

        case "WARNING":
            return root.warningColor

        case "CRITICAL":
            return root.criticalColor

        default:
            return root.unavailableColor
        }
    }
}
