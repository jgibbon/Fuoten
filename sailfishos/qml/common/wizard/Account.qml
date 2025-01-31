/* Fuoten - ownCloud/Nextcloud News App Client
 * Copyright (C) 2016-2019 Huessenbergnetz/Matthias Fehring
 * https://github.com/Huessenbergnetz/Fuoten
 *
 * sailfishos/qml/common/wizard/Account.qml
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.2
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import harbour.fuoten 1.0
import "../parts"

Dialog {
    id: welcomeAccountDialog

    backNavigation: false
    canAccept: config.isAccountValid && !account.inOperation
    acceptDestination: Screen.sizeCategory >= Screen.Large
                       ? Qt.resolvedUrl("../../tablet/pages/MainPage.qml")
                       : Qt.resolvedUrl("../../phone/pages/MainPage.qml")
    acceptDestinationAction: PageStackAction.Replace

    onAccepted: {
        config.setCurrentVersion()
        synchronizer.sync()
    }


    SilicaFlickable {
        id: welcomeAccountFlick
        anchors.fill: parent
        contentHeight: (accountGrid.visible ? accountGrid.height : 0) + account.height + dHeader.height

        VerticalScrollDecorator { flickable: welcomeAccountFlick; page: welcomeAccountDialog }

        PullDownMenu {
            visible: !config.isAccountValid
            flickable: welcomeAccountFlick
            MenuItem {
                //: Pull down/push up menu entry
                //% "Check account"
                text: qsTrId("fuoten-check-account")
                enabled: username.text.length > 0 && password.text.length > 0 && host.text.length > 0
                onClicked: {
                    config.username = username.text
                    config.password = password.text
                    config.host = host.text
                    config.serverPort = port.text.length > 0 ? parseInt(port.text) : 0
                    config.installPath = installPath.text
                    config.useSSL = usessl.checked
                    config.ignoreSSLErrors = ignoresslerrors.checked
                    account.validate()
                }
            }
        }

        PushUpMenu {
            visible: !config.isAccountValid
            flickable: welcomeAccountFlick
            MenuItem {
                text: qsTrId("fuoten-check-account")
                enabled: username.text.length > 0 && password.text.length > 0 && host.text.length > 0
                onClicked: {
                    config.username = username.text
                    config.password = password.text
                    config.host = host.text
                    config.serverPort = port.text.length > 0 ? parseInt(port.text) : 0
                    config.installPath = installPath.text
                    config.useSSL = usessl.checked
                    config.ignoreSSLErrors = ignoresslerrors.checked
                    account.validate()
                }
            }
        }

        DialogHeader {
            id: dHeader;
            title: qsTrId("id-user-account");
            dialog: welcomeAccountDialog;
            flickable: welcomeAccountFlick
            //: Text for finishing the first start configuration wizard
            //% "Finish"
            defaultAcceptText: qsTrId("fuoten-wizard-finish")
        }

        AccountItem {
            id: account
            anchors { left: parent.left; right: parent.right; top: dHeader.bottom }
            enabled: false
        }

        GridLayout {
            id: accountGrid
            anchors { left: parent.left; right: parent.right; top: dHeader.bottom; topMargin: account.contentHeight }
            visible: !account.inOperation && !config.isAccountValid

            columnSpacing: 0
            rowSpacing: Theme.paddingSmall

            columns: Screen.sizeCategory < Screen.Large ? (welcomeAccountDialog.isLandscape ? 2 : 1) : (welcomeAccountDialog.isLandscape ? 4 : 2)

            Item {
                Layout.columnSpan: accountGrid.columns
                Layout.fillWidth: true
                Layout.preferredHeight: infoText.height

                Text {
                    id: infoText
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    wrapMode: Text.WordWrap
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    //% "Set up your user account by entering your user name, your password and the host address of the server your ownCloud/Nextcloud is running on. If your ownCloud/Nextcloud is installed in a subdirectory on your server, you have to enter the installation path as well. If your server uses an other port than the default port for HTTP(S), enter it in server port. If you use the standard ports or if you do not know what this is all about, keep the 0 at the server port."
                    text: qsTrId("id-account-setup-info")
                    textFormat: Text.PlainText
                }
            }

            TextField {
                id: username
                Layout.fillWidth: true
                //: Label and placeholder for a text input
                //% "User name"
                label: qsTrId("id-user-name"); placeholderText: label
                inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: password.focus = true
            }

            TextField {
                id: password
                Layout.fillWidth: true
                //: Label and placeholder for a text input
                //% "Password"
                label: qsTrId("id-password"); placeholderText: label
                echoMode: TextInput.Password
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: host.focus = true
            }

            TextField {
                id: host
                Layout.fillWidth: true
                //: Label for a text input
                //% "Host"
                label: qsTrId("id-host")
                //: Placeholder for a text input
                //% "Host: e.g. cloud.example.com"
                placeholderText: qsTrId("id-host-placeholder")
                inputMethodHints: Qt.ImhUrlCharactersOnly
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: installPath.focus = true
            }

            TextField {
                id: installPath
                Layout.fillWidth: true
                //: Label and placeholder for a text input
                //% "Installation path"
                label: qsTrId("id-server-path"); placeholderText: label
                inputMethodHints: Qt.ImhUrlCharactersOnly
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: port.focus = true
            }

            TextField {
                id: port
                Layout.fillWidth: true
                //: Label and placeholder for a text input
                //% "Server port"
                label: qsTrId("id-server-port"); placeholderText: label
                inputMethodHints: Qt.ImhDigitsOnly
                validator: IntValidator { bottom: 0; top: 65536 }
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: port.focus = false
                text: "0"
            }

            Item {
                Layout.fillWidth: true
                Layout.columnSpan: Screen.sizeCategory < Screen.Large ? 1 : (welcomeAccountDialog.isLandscape ? 3 : 1)
                height: 1
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: usessl.implicitHeight
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                TextSwitch {
                    id: usessl
                    //: Label for a switch
                    //% "Use HTTPS (SSL/TLS) connection"
                    text: qsTrId("id-use-ssl-text")
                    //: Description for a switch
                    //% "Because the News App requires to send your username and password with every request, you should keep this enabled to use an encrypted connection, when your server supports or even requires encryption."
                    description: qsTrId("id-use-ssl-desc")
                    checked: true
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: ignoresslerrors.implicitHeight
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                TextSwitch {
                    id: ignoresslerrors
                    //: Label for a switch
                    //% "Ignore SSL errors"
                    text: qsTrId("id-ignore-ssl-errs-text")
                    //: Description for a switch
                    //% "Only ignore SSL errors when you really know what you are doing. Ignoring SSL errors is a big security risk."
                    description: qsTrId("id-ignore-ssl-errs-desc")
                    enabled: usessl.checked
                    checked: false
                }
            }
        }
    }
}

