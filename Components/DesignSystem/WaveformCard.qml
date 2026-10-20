import QtQuick
import QtQuick.Layouts

PulseCard {
    id: root

    PulseTheme {
        id: theme
    }

    // Monitoring information
    property string title: "ECG"
    property string unit: "mV"

    // Waveform appearance
    property color waveformColor: theme.heartRateColor

    // Waveform component
    property Component waveformDelegate: null

    // Loaded waveform access
    readonly property var waveformItem: waveformLoader.item

    // Layout configuration
    property int waveformPadding: theme.paddingMedium
    property int waveformSpacing: theme.spacingSmall
    property int headerSpacing: theme.spacingCard
    property int headerHeight: 24
    property int minimumWaveformHeight: 24

    // Typography
    property int titleSize: theme.fontHeading
    property int unitSize: theme.fontSmall

    // Default dimensions
    preferredWidth: 500
    preferredHeight: theme.cardMediumHeight
    contentPadding: root.waveformPadding

    ColumnLayout {
        anchors.fill: parent

        spacing: root.waveformSpacing

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: root.headerHeight

            spacing: root.headerSpacing

            PulseLabel {
                text: root.title

                labelColor: root.waveformColor
                labelSize: root.titleSize
                emphasized: true
            }

            PulseLabel {
                text: root.unit

                labelColor: theme.textPrimary
                labelSize: root.unitSize
            }

            Item {
                Layout.fillWidth: true
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: root.minimumWaveformHeight

            clip: true

            Loader {
                id: waveformLoader

                anchors.fill: parent
                sourceComponent: root.waveformDelegate
            }
        }
    }
}
