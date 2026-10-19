import QtQuick
import PulseCore

Row {
    id: root
    spacing: 16

    property bool running: false
    property int heartRate: 75

    // Expose the ECG component to the parent.
    readonly property alias ecgWaveform: ecgMonitor

    EcgWaveform {
        id: ecgMonitor
        width: (root.width - root.spacing) * 0.60
        height: root.height
    }

    Heart3D {
        id: heartMonitor
        width: (root.width - root.spacing) * 0.40
        height: root.height
        running: root.running
        heartRate: root.heartRate
    }

    function addEcgSample(sample) {
        ecgMonitor.addSample(sample)
    }

    function clearEcgSamples() {
        ecgMonitor.clearSamples()
    }
}
