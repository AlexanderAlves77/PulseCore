import QtQuick

Item {
    id: root

    PulseTheme {
        id: theme
    }

    // Placeholder content
    property string message: "SIGNAL NOT IMPLEMENTED"

    // Appearance
    property color gridColor: theme.waveformGrid
    property color messageColor: theme.textMuted

    // Typography
    property int messageSize: theme.fontSmall

    // Grid configuration
    property int gridSize: 24
    property real gridLineWidth: 0.5

    clip: true

    Canvas {
        id: gridCanvas
        anchors.fill: parent

        onPaint: {
            const context = getContext("2d")
            context.reset()

            context.strokeStyle = root.gridColor
            context.lineWidth = root.gridLineWidth

            for (let x = 0; x < width; x += root.gridSize) {
                context.beginPath()
                context.moveTo(x, 0)
                context.lineTo(x, height)
                context.stroke()
            }

            for (let y = 0; y < height; y += root.gridSize) {
                context.beginPath()
                context.moveTo(0, y)
                context.lineTo(width, y)
                context.stroke()
            }
        }

        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
    }

    PulseLabel {
        id: placeholderLabel
        anchors.centerIn: parent
        text: root.message
        labelSize: root.messageSize
        labelColor: root.messageColor
    }

    onGridColorChanged: gridCanvas.requestPaint()
    onGridSizeChanged: gridCanvas.requestPaint()
    onGridLineWidthChanged: gridCanvas.requestPaint()
}
