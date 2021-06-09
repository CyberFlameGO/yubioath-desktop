import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

Flickable {

    id: settingsPanel
    objectName: 'fingerPrintsViewFlickable'
    contentWidth: app.width
    contentHeight: expandedHeight

    property var expandedHeight: content.implicitHeight + dynamicMargin

    onExpandedHeightChanged: {
        if (expandedHeight > app.height - toolBar.height) {
             scrollBar.active = true
         }
    }

    ScrollBar.vertical: ScrollBar {
        id: scrollBar
        width: 8
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        hoverEnabled: true
        z: 2
    }
    boundsBehavior: Flickable.StopAtBounds

    property string searchFieldPlaceholder: ""

    ColumnLayout {
        width: settingsPanel.contentWidth
        id: content
        spacing: 0

        ColumnLayout {
            width: settingsPanel.contentWidth - 32
            Layout.leftMargin: 16
            Layout.rightMargin: 16

            Label {
                text: "Fingerprints"
                font.pixelSize: 16
                font.weight: Font.Normal
                color: yubicoGreen
                opacity: fullEmphasis
                Layout.topMargin: 24
                Layout.bottomMargin: 24
                Layout.fillWidth: true
            }

            Label {
                text: yubiKey.fingerprints.length > 0 ? qsTr("Fingerprints on this YubiKey") : qsTr("There's no fingerprints on this YubiKey")
                color: primaryColor
                opacity: lowEmphasis
                font.pixelSize: 13
                lineHeight: 1.2
                textFormat: TextEdit.PlainText
                wrapMode: Text.WordWrap
                Layout.maximumWidth: parent.width
                Layout.bottomMargin: 16
            }

            Repeater {
                model: yubiKey.fingerprints
                StyledTextField {
                    text: modelData.name ? modelData.name : modelData.id
                    enabled: false
                    noedit: true
                }
            }

            StyledButton {
                text: qsTr("Add")
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                onClicked: navigator.goToNewFingerPrintView()
                Keys.onEnterPressed: navigator.goToNewFingerPrintView()
                Keys.onReturnPressed: navigator.goToNewFingerPrintView()
            }
        }
    }
}
