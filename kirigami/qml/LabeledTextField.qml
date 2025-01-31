/* Fuoten - ownCloud/Nextcloud News App Client
 * Copyright (C) 2016-2019 Huessenbergnetz/Matthias Fehring
 * https://github.com/Huessenbergnetz/Fuoten
 *
 * kirigami/qml/LabeledTextField.qml
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

import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import org.kde.kirigami 1.0 as Kirigami

ColumnLayout {
    id: textFieldRoot

    property alias label: textFieldLabel.text
    property alias placeholderText: textField.placeholderText
    property alias text: textField.text
    property alias inputMethodHints: textField.inputMethodHints
    property alias validator: textField.validator
    property alias acceptableInput: textField.acceptableInput
    property alias echoMode: textField.echoMode

    TextField {
        id: textField
        Layout.fillWidth: true
    }

    Kirigami.Label {
        id: textFieldLabel
        opacity: textField.text.length > 0 ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: Kirigami.Units.shortDuration } }
    }
}
