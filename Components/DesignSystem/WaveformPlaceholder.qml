import QtQuick

Item {
    id: root

    property string message: "SIGNAL NOT IMPLEMENTED"
    property color gridColor: "#16435A"

    clip: true

    Canvas {
        id: gridCanvas

        anchors.fill: parent

        onPaint: {
            const context = getContext("2d")

            context.reset()
            context.strokeStyle = root.gridColor
            context.lineWidth = 0.5

            const gridSize = 24

            for (let x = 0; x < width; x += gridSize) {
                context.beginPath()
                context.moveTo(x, 0)
                context.lineTo(x, height)
                context.stroke()
            }

            for (let y = 0; y < height; y += gridSize) {
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
        anchors.centerIn: parent

        text: root.message
        labelSize: 12
        labelColor: "#648398"
    }
}