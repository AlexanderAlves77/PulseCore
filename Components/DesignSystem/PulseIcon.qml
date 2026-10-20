import QtQuick

Item {
    id: root

    property string iconName: "heart"
    property color iconColor: "#00DDF2"

    property int iconSize: 28
    property real strokeWidth: 2.0

    property bool filled: false

    implicitWidth: iconSize
    implicitHeight: iconSize

    onIconNameChanged: iconCanvas.requestPaint()
    onIconColorChanged: iconCanvas.requestPaint()
    onStrokeWidthChanged: iconCanvas.requestPaint()
    onFilledChanged: iconCanvas.requestPaint()

    Canvas {
        id: iconCanvas

        anchors.fill: parent

        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()

        onPaint: {
            const context = getContext("2d")
            context.reset()

            context.strokeStyle = root.iconColor
            context.fillStyle = root.iconColor
            context.lineWidth = root.strokeWidth
            context.lineCap = "round"
            context.lineJoin = "round"

            const centerX = width / 2
            const centerY = height / 2
            const scale = Math.min(width, height) / root.iconSize

            context.save()
            context.translate(centerX, centerY)
            context.scale(scale, scale)

            switch (root.iconName){

            case "heart":
                context.beginPath()
                context.moveTo(0, 10)
                context.bezierCurveTo(-17, 0, -12, -13, 0, -7)
                context.bezierCurveTo(12, -13, 17, 0, 0, 10)
                context.closePath()

                if (root.filled)
                    context.fill()
                else
                    context.stroke()

                break

            case "ecg":
                context.beginPath()
                context.moveTo(-13, 0)
                context.lineTo(-9, 0)
                context.lineTo(-6, -4)
                context.lineTo(-3, 5)
                context.lineTo(1, -12)
                context.lineTo(5, 10)
                context.lineTo(8, 0)
                context.lineTo(13, 0)
                context.stroke()
                break

            case "patient":
                context.beginPath()
                context.arc(0, -6, 5, 0, Math.PI * 2)
                context.stroke()

                context.beginPath()
                context.moveTo(-10, 12)
                context.lineTo(-10, 8)
                context.quadraticCurveTo(-10, 1, 0, 1)
                context.quadraticCurveTo(10, 1, 10, 8)
                context.lineTo(10, 12)
                context.stroke()
                break

            case "clock":
                context.beginPath()
                context.arc(0, 0, 11, 0, Math.PI * 2)
                context.stroke()

                context.beginPath()
                context.moveTo(0, -7)
                context.lineTo(0, 0)
                context.lineTo(6, 4)
                context.stroke()
                break

            case "settings":
                context.beginPath()
                context.arc(0, 0, 7, 0, Math.PI * 2)
                context.stroke()

                context.beginPath()
                context.arc(0, 0, 2.5, 0, Math.PI * 2)
                context.stroke()

                for (let index = 0; index < 8; index++) {
                    const angle = index * Math.PI / 4

                    context.beginPath()
                    context.moveTo(
                        Math.cos(angle) * 9,
                        Math.sin(angle) * 9
                    )
                    context.lineTo(
                        Math.cos(angle) * 12,
                        Math.sin(angle) * 12
                    )
                    context.stroke()
                }
                break

            case "battery":
                context.strokeRect(-12, -7, 21, 14)
                context.fillRect(10, -3, 3, 6)
                break

            case "chevron-down":
                context.beginPath()
                context.moveTo(-7, -3)
                context.lineTo(0, 4)
                context.lineTo(7, -3)
                context.stroke()
                break

            case "lungs":
                context.beginPath();

                // Trachea
                context.moveTo(14, 3);
                context.lineTo(14, 11);

                // Left bronchus
                context.moveTo(14, 11);
                context.lineTo(10, 14);

                // Right bronchus
                context.moveTo(14, 11);
                context.lineTo(18, 14);

                context.stroke();

                // Left lung
                context.beginPath();
                context.moveTo(11, 7);
                context.bezierCurveTo(8, 7, 6, 10, 5, 14);
                context.bezierCurveTo(4, 18, 3, 23, 7, 24);
                context.bezierCurveTo(10, 25, 12, 22, 12, 19);
                context.lineTo(12, 12);
                context.stroke();

                // Right lung
                context.beginPath();
                context.moveTo(17, 7);
                context.bezierCurveTo(20, 7, 22, 10, 23, 14);
                context.bezierCurveTo(24, 18, 25, 23, 21, 24);
                context.bezierCurveTo(18, 25, 16, 22, 16, 19);
                context.lineTo(16, 12);
                context.stroke();

                break;

            case "thermometer":
                context.beginPath();

                // Thermometer body
                context.moveTo(11, 17);
                context.lineTo(11, 6);
                context.bezierCurveTo(11, 2, 17, 2, 17, 6);
                context.lineTo(17, 17);

                // Lower bulb
                context.bezierCurveTo(20, 19, 20, 23, 17, 25);
                context.bezierCurveTo(14, 27, 10, 25, 9, 22);
                context.bezierCurveTo(8, 20, 9, 18, 11, 17);

                context.stroke();

                // Mercury line
                context.beginPath();
                context.moveTo(14, 9);
                context.lineTo(14, 20);
                context.stroke();

                // Mercury bulb
                context.beginPath();
                context.arc(14, 21, 2, 0, Math.PI * 2);
                context.fill();

                break;

            default:
                console.warn("PulseIcon: unsupported icon:", root.iconName)
                break
            }

            context.restore()
        }
    }
}
