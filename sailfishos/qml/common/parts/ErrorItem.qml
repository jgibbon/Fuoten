/* Fuoten - ownCloud/Nextcloud News App Client
 * Copyright (C) 2016-2019 Huessenbergnetz/Matthias Fehring
 * https://github.com/Huessenbergnetz/Fuoten
 *
 * sailfishos/qml/common/parts/ErrorItem.qml
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

RowLayout {

    property bool highlighted: false
    property FuotenError error: null

    property real iconSize: Theme.iconSizeMedium
    property alias fontSize: errorText.font.pixelSize

    spacing: Theme.paddingMedium

    visible: error

    Image {
        source: "image://theme/icon-l-attention?" + (highlighted ? Theme.highlightColor : Theme.primaryColor)
        Layout.preferredWidth: iconSize
        Layout.preferredHeight: iconSize
        fillMode: Image.PreserveAspectFit
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }

    Text {
        id: errorText
        text: error ? error.text : ""
        color: highlighted ? Theme.highlightColor : Theme.primaryColor
        font.pixelSize: Theme.fontSizeSmall
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        maximumLineCount: 3
        elide: Text.ElideRight
    }
}

