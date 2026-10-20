import QtQuick
import QtQuick.Layouts

import "../DesignSystem"
import PulseCore

Item {
    id: root

    PulseTheme {
        id: theme
    }

    // Simulation configuration
    property int heartRate: 75
    property int respiratoryRate: 16

    property int maxSamples: 500
    property real sampleInterval: 0.016
    property int sampleIndex: 0

    // Waveform samples
    property var plethSamples: []
    property var respirationSamples: []
    property var capnographySamples: []

    // Waveform appearance
    property color plethColor: theme.oxygenColor
    property color respirationColor: theme.respiratoryColor
    property color capnographyColor: theme.co2Color

    property color waveformBackground: theme.waveformBackground
    property color waveformGrid: theme.waveformGrid

    property int panelSpacing: theme.spacingCard
    property int gridSize: 24
    property real waveformLineWidth: 2.0

    // Shared mathematical helpers
    function clamp(value, minimum, maximum) {
        return Math.max(minimum, Math.min(maximum, value))
    }

    function getFrequency(rate, minimumRate) {
        return Math.max(minimumRate, rate) / 60.0
    }

    function getCyclePhase(timeSeconds, frequency) {
        return (timeSeconds * frequency) % 1.0
    }

    function gaussianPulse(phase, center, width)
    {
        const distance = (phase - center) / width

        return Math.exp(-(distance * distance))
    }

    // Plethysmography generation
    function generatePlethSample(timeSeconds)
    {
        const frequency = getFrequency(root.heartRate, 30)
        const phase = getCyclePhase(timeSeconds, frequency)

        const systolic = gaussianPulse(phase, 0.20, 0.11)
        const diastolic = 0.30 * gaussianPulse(phase, 0.48, 0.18)
        const notch = 0.10 * gaussianPulse(phase, 0.39, 0.045)

        return clamp(systolic + diastolic - notch, 0, 1)
    }

    // Respiratory waveform generation
    function generateRespirationSample(timeSeconds)
    {
        const frequency = getFrequency(root.respiratoryRate, 4)
        const phase = timeSeconds * frequency * 2.0 * Math.PI

        const primaryWave = 0.43 * Math.sin(phase)
        const secondaryWave = 0.04 * Math.sin(phase * 2.0)

        return clamp(0.5 + primaryWave + secondaryWave, 0, 1)
    }

    // Capnography generation
    function generateCapnographySample(timeSeconds)
    {
        const frequency = getFrequency(root.respiratoryRate, 4)
        const phase = getCyclePhase(timeSeconds, frequency)

        if (phase < 0.12)
            return 0.04

        if (phase < 0.23)
            return generateCo2Rise(phase)

        if (phase < 0.65)
            return generateCo2Plateau(phase)

        if (phase < 0.76)
            return generateCo2Fall(phase)

        return 0.04
    }

    function generateCo2Rise(phase)
    {
        const progress = (phase - 0.12) / 0.11

        return 0.04 + 0.82 * progress
    }

    function generateCo2Plateau(phase)
    {
        const progress = (phase - 0.23) / 0.42

        return 0.86 + 0.08 * progress
    }

    function generateCo2Fall(phase)
    {
        const progress = (phase - 0.65) / 0.11

        return 0.94 * (1.0 - progress)
    }

    // Sample management
    function appendSample(samples, value)
    {
        const updatedSamples = samples.slice()

        updatedSamples.push(value)

        if (updatedSamples.length > root.maxSamples)
            updatedSamples.shift()

        return updatedSamples
    }

    function appendGeneratedSamples(timeSeconds)
    {
        root.plethSamples = appendSample(
            root.plethSamples,
            generatePlethSample(timeSeconds)
        )

        root.respirationSamples = appendSample(
            root.respirationSamples,
            generateRespirationSample(timeSeconds)
        )

        root.capnographySamples = appendSample(
            root.capnographySamples,
            generateCapnographySample(timeSeconds)
        )
    }

    function clearGeneratedSamples()
    {
        root.plethSamples = []
        root.respirationSamples = []
        root.capnographySamples = []
        root.sampleIndex = 0
    }

    // Canvas rendering
    function prepareCanvas(canvas)
    {
        const context = canvas.getContext("2d")

        context.reset()
        context.clearRect(0, 0, canvas.width, canvas.height)

        return context
    }

    function drawBackground(context, width, height)
    {
        context.fillStyle = root.waveformBackground
        context.fillRect(0, 0, width, height)
    }

    function drawVerticalGrid(context, width, height)
    {
        for (let x = 0; x < width; x += root.gridSize)
        {
            context.beginPath()
            context.moveTo(x, 0)
            context.lineTo(x, height)
            context.stroke()
        }
    }

    function drawHorizontalGrid(context, width, height)
    {
        for (let y = 0; y < height; y += root.gridSize)
        {
            context.beginPath()
            context.moveTo(0, y)
            context.lineTo(width, y)
            context.stroke()
        }
    }

    function drawGrid(context, width, height)
    {
        context.save()

        context.strokeStyle = root.waveformGrid
        context.lineWidth = 0.5
        context.globalAlpha = 0.55

        drawVerticalGrid(context, width, height)
        drawHorizontalGrid(context, width, height)

        context.restore()
    }

    function getSampleX(index, sampleCount, width)
    {
        const stepX = width / Math.max(1, root.maxSamples - 1)
        const startX = width - (sampleCount - 1) * stepX

        return startX + index * stepX
    }

    function getSampleY(sample, height)
    {
        const normalized = clamp(sample, 0, 1)
        const topMargin = height * 0.12
        const usableHeight = height * 0.76

        return height - topMargin - normalized * usableHeight
    }

    function configureWaveformPen(context, lineColor)
    {
        context.strokeStyle = lineColor
        context.lineWidth = root.waveformLineWidth
        context.lineJoin = "round"
        context.lineCap = "round"
    }

    function drawSamplePath(context, samples, width, height)
    {
        context.beginPath()

        for (let index = 0; index < samples.length; ++index)
        {
            const x = getSampleX(index, samples.length, width)
            const y = getSampleY(samples[index], height)

            if (index === 0)
                context.moveTo(x, y)
            else
                context.lineTo(x, y)
        }

        context.stroke()
    }

    function drawWaveform(canvas, samples, lineColor)
    {
        const width = canvas.width
        const height = canvas.height

        if (width <= 0 || height <= 0)
            return

        const context = prepareCanvas(canvas)

        drawBackground(context, width, height)
        drawGrid(context, width, height)

        if (samples.length < 2)
            return

        configureWaveformPen(context, lineColor)
        drawSamplePath(context, samples, width, height)
    }

    // Monitoring layout
    ColumnLayout {
        id: waveformLayout

        anchors.fill: parent
        spacing: root.panelSpacing

        // ECG
        WaveformCard {
            id: ecgCard

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 180
            Layout.minimumHeight: 90

            title: "ECG"
            unit: "Lead II · mV"
            waveformColor: theme.heartRateColor

            waveformDelegate: EcgWaveform {
                waveformColor: ecgCard.waveformColor
            }
        }

        // Plethysmography
        WaveformCard {
            id: plethCard

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 120
            Layout.minimumHeight: 75

            title: "SpO2"
            unit: "Pleth"
            waveformColor: root.plethColor

            waveformDelegate: Item {
                clip: true

                Canvas {
                    id: plethCanvas

                    anchors.fill: parent

                    onPaint: root.drawWaveform(
                        plethCanvas,
                        root.plethSamples,
                        root.plethColor
                    )

                    onWidthChanged: requestPaint()
                    onHeightChanged: requestPaint()

                    Connections {
                        target: root

                        function onPlethSamplesChanged() {
                            plethCanvas.requestPaint()
                        }
                    }
                }
            }
        }

        // Respiration
        WaveformCard {
            id: respirationCard

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 120
            Layout.minimumHeight: 75

            title: "RESP"
            unit: "Respiration"
            waveformColor: root.respirationColor

            waveformDelegate: Item {
                clip: true

                Canvas {
                    id: respirationCanvas

                    anchors.fill: parent

                    onPaint: root.drawWaveform(
                        respirationCanvas,
                        root.respirationSamples,
                        root.respirationColor
                    )

                    onWidthChanged: requestPaint()
                    onHeightChanged: requestPaint()

                    Connections {
                        target: root

                        function onRespirationSamplesChanged() {
                            respirationCanvas.requestPaint()
                        }
                    }
                }
            }
        }

        // Capnography
        WaveformCard {
            id: capnographyCard

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 120
            Layout.minimumHeight: 75

            title: "CO2"
            unit: "Capnography"
            waveformColor: root.capnographyColor

            waveformDelegate: Item {
                clip: true

                Canvas {
                    id: capnographyCanvas

                    anchors.fill: parent

                    onPaint: root.drawWaveform(
                        capnographyCanvas,
                        root.capnographySamples,
                        root.capnographyColor
                    )

                    onWidthChanged: requestPaint()
                    onHeightChanged: requestPaint()

                    Connections {
                        target: root

                        function onCapnographySamplesChanged() {
                            capnographyCanvas.requestPaint()
                        }
                    }
                }
            }
        }
    }

    // Public API - Called by Main.qml
    function addEcgSample(sample) {
        if (ecgCard.waveformItem)
            ecgCard.waveformItem.addSample(sample)

        const timeSeconds = root.sampleIndex * root.sampleInterval

        appendGeneratedSamples(timeSeconds)

        root.sampleIndex++
    }

    function clearEcgSamples() {
        if (ecgCard.waveformItem)
            ecgCard.waveformItem.clearSamples()

        clearGeneratedSamples()
    }
}