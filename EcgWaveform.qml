import QtQuick

Rectangle {
    id: ecgWaveform
    radius: 12
    color: "#101A27"

    property color waveColor: "#40DCA5"
    property color gridColor: "#203447"
    property real animationOffset: 0
    property bool running: true

    implicitWidth: 760
    implicitHeight: 320

    border.color: "#263548"
    border.width: 1

    Text {
        id: chartTitle
        text: "ECG — SIMULATED"
        color: "#91A3B8"
        font.pixelSize: 15
        font.bold: true
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
    }

    Canvas {
        id: chartCanvas
        anchors.top: chartTitle.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20

        onPaint: {
            const context = getContext("2d");
            context.reset();

            drawGrid(context);
            drawWaveform(context);
        }

        function drawGrid(context)
        {
            const gridSize = 25;

            context.beginPath();
            context.strokeStyle = ecgWaveform.gridColor;
            context.lineWidth = 0.5;

            for (let x = 0; x <= width; x += gridSize)
            {
                context.moveTo(x, 0);
                context.lineTo(x, height);
            }

            for (let y = 0; y <= height; y += gridSize)
            {
                context.moveTo(0, y);
                context.lineTo(width, y);
            }

            context.stroke();
        }

        function getWaveAmplitude(phase)
        {
            if (phase < 0.10) return 0;

            if (phase < 0.18) {
                return -0.12 * Math.sin(((phase - 0.10) / 0.08) * Math.PI);
            }

            if (phase < 0.28) return 0;

            if (phase < 0.32) return 0.15;

            if (phase < 0.36) return -0.85;

            if (phase < 0.40) return 0.25;

            if (phase < 0.48) return 0;

            if (phase < 0.65) {
                return 0.20 * Math.sin(((phase - 0.48) / 0.17) * Math.PI);
            }

            return 0;
        }

        function drawWaveform(context)
        {
            const centerY = height / 2;
            const amplitude = height * 0.38;
            const cycleWidth = 180;

            context.beginPath();
            context.strokeStyle = ecgWaveform.waveColor;
            context.lineWidth = 2.5;
            context.lineJoin = "round";

            for (let x = 0; x < width; x += 2)
            {
                const position = (x + ecgWaveform.animationOffset) / cycleWidth;
                const phase = position - Math.floor(position);
                const y = centerY + getWaveAmplitude(phase) * amplitude;

                if (x === 0) context.moveTo(x, y);
                else context.lineTo(x, y);
            }

            context.stroke();
        }
    }

    NumberAnimation on animationOffset
    {
        from: 0
        to: 180
        duration: 1800
        loops: Animation.Infinite
        running: ecgWaveform.running
    }

    onAnimationOffsetChanged: chartCanvas.requestPaint();
}
