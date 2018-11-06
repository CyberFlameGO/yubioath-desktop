import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2

DefaultDialog {
    id: setPasswordPrompt
    title: qsTr("Set new password")
    modality: Qt.ApplicationModal
    property string newPassword: newPassword.text
    property bool matchingPasswords: newPassword.text === confirmPassword.text
    property bool remember: rememberPassword.checked

    onVisibilityChanged: {
        // Clear the password from old canceled entries
        // when a new dialog is shown.
        if (visible) {
            clear()
        }
    }

    ColumnLayout {
        Layout.fillHeight: true
        Layout.fillWidth: true

        GridLayout {
            columns: 2
            Label {
                text: qsTr("New password (blank for none): ")
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.fillWidth: false
            }
            TextField {
                id: newPassword
                focus: true
                echoMode: TextInput.Password
                Layout.fillWidth: true
                KeyNavigation.tab: confirmPassword
                Keys.onEscapePressed: close()
            }
            Label {
                text: qsTr("Confirm password: ")
            }
            TextField {
                id: confirmPassword
                echoMode: TextInput.Password
                Layout.fillWidth: true
                onAccepted: promptAccepted()
                KeyNavigation.tab: rememberPassword
                Keys.onEscapePressed: close()
            }
        }
        RowLayout {
            CheckBox {
                id: rememberPassword
                text: qsTr("Remember password")
                KeyNavigation.tab: setPasswordBtn
                Keys.onEscapePressed: close()
            }
        }
        RowLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            Button {
                id: setPasswordBtn
                text: qsTr("Set password")
                enabled: matchingPasswords
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                onClicked: promptAccepted()
                KeyNavigation.tab: cancelBtn
                Keys.onEscapePressed: close()
            }
            Button {
                id: cancelBtn
                text: qsTr("Cancel")
                onClicked: close()
                KeyNavigation.tab: newPassword
                Keys.onEscapePressed: close()
            }
        }
    }
    function promptAccepted() {
        if (matchingPasswords) {
            close()
            accepted()
        }
    }

    function clear() {
        newPassword.text = ""
        confirmPassword.text = ""
    }
}
