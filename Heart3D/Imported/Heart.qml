import QtQuick
import QtQuick3D

Node {
    id: root
    objectName: "Root"

    // Resources
    property url textureData: "maps/textureData.jpg"
    property url textureData7: "maps/textureData7.jpg"

    Texture {
        id: _0_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData
    }

    Texture {
        id: _1_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: root.textureData7
    }

    PrincipledMaterial {
        id: base_material_material
        objectName: "base_material"
        baseColorMap: _0_texture
        roughness: 1
        normalMap: _1_texture
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
        indexOfRefraction: 1.4500000476837158
    }

    // Nodes:
    Model {
        id: mesh
        objectName: "mesh"
        rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)
        scale: Qt.vector3d(0.58183, 0.58183, 0.58183)
        source: "meshes/mesh_mesh.mesh"
        materials: [
            base_material_material
        ]

        onBoundsChanged: {
            console.log("Heart mesh bounds updated:")
            console.log("Minimum:", bounds.minimum)
            console.log("Maximum:", bounds.maximum)
        }
    }

    // Animations:
}
