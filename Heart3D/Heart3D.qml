import QtQuick
import QtQuick3D

Rectangle {
    id: heart3D
    radius: 12
    color: "#101A27"

    property bool running: true
    property int heartRate: 78

    readonly property int beatDuration: Math.round(60000 / Math.max(1, heartRate))

    implicitWidth: 360
    implicitHeight: 300

    border.color: "#263548"
    border.width: 1

    Text {
        id: sceneTitle
        text: "3D HEART - SIMULATED"
        color: "#91A3B8"
        font.pixelSize: 15
        font.bold: true
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
    }

    View3D {
        id: heartView
        anchors.top: sceneTitle.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 12

        environment: SceneEnvironment {
            backgroundMode: SceneEnvironment.Transparent
        }

        PerspectiveCamera {
            id: heartCamera
            position: Qt.vector3d(0, 0, 3)
            clipNear: 0.01
            clipFar: 1000
        }

        DirectionalLight {
            eulerRotation.x: -30
            eulerRotation.y: -40
            brightness: 2.0
            castsShadow: false
        }

        Node {
            id: heartNode

            Heart {
                id: anatomicalHeart
                position: Qt.vector3d(0, 0, 0)
                scale: Qt.vector3d(3.0, 3.0, 3.0)
            }

            NumberAnimation on eulerRotation.y {
                from: 0
                to: 360
                duration: 16000
                loops: Animation.Infinite
                running: heart3D.running
            }

            SequentialAnimation on scale {
                loops: Animation.Infinite
                running: heart3D.running

                Vector3dAnimation {
                    from: Qt.vector3d(1.0, 1.0, 1.0)
                    to: Qt.vector3d(1.08, 1.08, 1.08)
                    duration: Math.round(heart3D.beatDuration * 0.20)
                    easing.type: Easing.OutQuad
                }

                Vector3dAnimation {
                    from: Qt.vector3d(1.10, 1.10, 1.10)
                    to: Qt.vector3d(1.0, 1.0, 1.0)
                    duration: Math.round(heart3D.beatDuration * 0.80)
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}

