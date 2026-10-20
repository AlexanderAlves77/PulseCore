import QtQuick

Row {
    id: root

    PulseTheme {
        id: theme
    }

    // Status
    property string status: "STOPPED"

    // Appearance
    property color runningColor: theme.normal
    property color pausedColor: theme.warning
    property color stoppedColor: theme.textMuted

    property int indicatorSize: 9
    property int contentSpacing: theme.spacingSmall
    property int textSize: theme.fontSmall

    // Animation
    property bool animated: true
    property int pulseDuration: 650
    property real minimumOpacity: 0.35

    // Derived properties
    readonly property string normalizedStatus: root.status.trim().toUpperCase()

    readonly property color indicatorColor:
    {
        switch (root.normalizedStatus)
        {
        case "RUNNING":
            return root.runningColor

        case "PAUSED":
            return root.pausedColor

        default:
            return root.stoppedColor
        }
    }

    spacing: root.contentSpacing

    Rectangle {
        id: statusDot
        width: root.indicatorSize
        height: root.indicatorSize
        radius: width / 2

        anchors.verticalCenter: parent.verticalCenter

        color: root.indicatorColor

        SequentialAnimation on opacity {
            running: root.animated && root.normalizedStatus === "RUNNING"

            loops: Animation.Infinite

            NumberAnimation {
                to: root.minimumOpacity
                duration: root.pulseDuration
            }

            NumberAnimation {
                to: 1.0
                duration: root.pulseDuration
            }

            onStopped: {
                statusDot.opacity = 1.0
            }
        }
    }

    PulseLabel {
        id: statusLabel
        text: root.status
        labelColor: root.indicatorColor
        labelSize: root.textSize
        emphasized: true
    }
}
