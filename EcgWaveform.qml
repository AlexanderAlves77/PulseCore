import QtQuick

Item {
    id: root

    property var samples: []
    property int maxSamples: 500
    property color waveformColor: "#00FF88"

    function AddSample(value) {
        if (!Number.isFinite(value))
            return

        var updatedSamples = samples.slice()

        updatedSamples.push(value)

        if (updatedSamples.length > maxSamples)
            updatedSamples.shift()

        samples = updatedSamples
        waveformCanvas.requestPaint()
    }

    function ClearSamples() {
        samples = []
        waveformCanvas.requestPaint()
    }

    Canvas {
        id: waveformCanvas

        anchors.fill: parent

        onPaint: {
            var context = getContext("2d")

            context.reset()

            if (root.samples.length < 2)
                return

            context.strokeStyle = root.waveformColor
            context.lineWidth = 2
            context.beginPath()

            var stepX = width / (root.maxSamples - 1)
            var centerY = height * 0.5
            var amplitude = height * 0.4

            for (var index = 0; index < root.samples.length; ++index)
            {
                var x = index * stepX
                var y = centerY - root.samples[index] * amplitude

                if (index === 0)
                    context.moveTo(x, y)
                else
                    context.lineTo(x, y)
            }

            context.stroke()
        }
    }
}
