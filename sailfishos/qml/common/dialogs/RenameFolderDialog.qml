/* Fuoten - ownCloud/Nextcloud News App Client
 * Copyright (C) 2016-2019 Huessenbergnetz/Matthias Fehring
 * https://github.com/Huessenbergnetz/Fuoten
 *
 * sailfishos/qml/common/dialogs/RenameFolderDialog.qml
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
import Sailfish.Silica 1.0
import harbour.fuoten.items 1.0

Dialog {
    id: renameFolderDialog

    property string newName: ""

    property Folder folder: null

    canAccept: folder && (newName.length > 0) && (newName !== dHeader.title)

    onAccepted: if (folder) { folder.rename(renameFolderDialog.newName, config, localstorage) }

    SilicaFlickable {
        id: renameFolderDialogFlick
        anchors.fill: parent

        contentHeight: renameFolderCol.height + dHeader.height

        DialogHeader {
            id: dHeader
            acceptText: qsTrId("fuoten-rename-folder")
            dialog: renameFolderDialog
            flickable: renameFolderDialogFlick
            title: folder ? folder.name : ""
        }

        Column {
            id: renameFolderCol
            anchors { left: parent.left; right: parent.right; top: dHeader.bottom }
            spacing: Theme.paddingMedium

            TextField {
                id: newNameField
                width: parent.width
                label: qsTrId("fuoten-new-folder-name"); placeholderText: label
                text: folder ? folder.name : ""
                EnterKey.enabled: renameFolderDialog.canAccept
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked: renameFolderDialog.accept()
                onTextChanged: renameFolderDialog.newName = text.trim()
            }
        }
    }
}
