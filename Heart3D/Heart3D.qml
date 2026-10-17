import QtQuick
import QtQuick3D

Rectangle {
    id: heart3D
    radius: 12
    color: "#101A27"

    property bool running: true

    implicitWidth: 360
    implicitHeight: 300

    border.color: "#263548"
    border.width: 1

    Text {
        id: sceneTitle
        text: "3D HEART - PREVIEW"
        color: "#91A3B8"
        font.pixelSize: 15
        font.bold: true
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
    }

    View3D {
        anchors.top: sceneTitle.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 12

        environment: SceneEnvironment {
            backgroundMode: SceneEnvironment.Transparent
        }

        PerspectiveCamera {
            z: 350
        }

        DirectionalLight {
            eulerRotation.x: -30
            eulerRotation.y: -40
            brightness: 1.5
        }

        Node {
            id: heartNode

            Model {
                source: "#Sphere"
                scale: Qt.vector3d(1.3, 1.5, 1.1)
                materials: PrincipledMaterial {
                    baseColor: "#B91C36"
                    metalness: 0.05
                    roughness: 0.35
                }
            }

            NumberAnimation on eulerRotation.y {
                from: 0
                to: 360
                duration: 12000
                loops: Animation.Infinite
                running: heart3D.running
            }

            SequentialAnimation on scale {
                loops: Animation.Infinite
                running: heart3D.running

                Vector3dAnimation {
                    from: Qt.vector3d(1.0, 1.0, 1.0)
                    to: Qt.vector3d(1.10, 1.10, 1.10)
                    duration: 180
                    easing.type: Easing.OutQuad
                }

                Vector3dAnimation {
                    from: Qt.vector3d(1.10, 1.10, 1.10)
                    to: Qt.vector3d(1.0, 1.0, 1.0)
                    duration: 600
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}

