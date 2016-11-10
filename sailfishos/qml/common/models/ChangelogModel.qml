/* Fuoten - ownCloud/Nextcloud News App Client
 * Copyright (C) 2016 Buschtrommel/Matthias Fehring
 * https://www.buschmann23.de/entwicklung/anwendungen/fuoten/
 * https://github.com/Buschtrommel/Fuoten
 *
 * sailfishos/qml/common/models/ChangelogModel.qml
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

/*
  Types:
  0 - New
  1 - Improved/Enhanced
  2 - Fixed
  3 - Note
*/

ListModel {
    ListElement {
        version: "0.4.0"
        date: 1478792919000
        entries: [
            ListElement { type: 3; issue: ""; description: "fourth preview release" },
            ListElement { type: 0; issue: "24"; description: "show last sync time in pull down menu" },
            ListElement { type: 0; issue: "23"; description: "copy article url to clipboard menu entry" },
            ListElement { type: 0; issue: "15"; description: "article content display" },
            ListElement { type: 0; issue: "19"; description: "context setting for article opening" },
            ListElement { type: 0; issue: "18"; description: "mark all articles as read" },
            ListElement { type: 0; issue: "20"; description: "optional article excerpt in article list" },
            ListElement { type: 0; issue: ""; description: "Swedish translation by Åke Engelbrektson" }
        ]
    }

    ListElement {
        version: "0.3.0"
        date: 1478558957000
        entries: [
            ListElement { type: 3; issue: ""; description: "third preview release" },
            ListElement { type: 0; issue: "14"; description: "article list" },
            ListElement { type: 0; issue: "16"; description: "mark articles as read/unread" },
            ListElement { type: 0; issue: "17"; description: "star/unstar articles" },
            ListElement { type: 0; issue: ""; description: "partly Danish translation by Peter Jespersen" }
        ]
    }

    ListElement {
        version: "0.2.0"
        date: 1478089348000
        entries: [
            ListElement { type: 3; issue: ""; description: "second preview release"},
            ListElement { type: 0; issue: "6"; description: "feeds list view" },
            ListElement { type: 0; issue: "8"; description: "feeds list sorting" },
            ListElement { type: 0; issue: "12"; description: "mark feeds as read" },
            ListElement { type: 0; issue: "11"; description: "move feeds" },
            ListElement { type: 0; issue: "9"; description: "add feeds" },
            ListElement { type: 0; issue: "13"; description: "delete feeds" },
            ListElement { type: 0; issue: "10"; description: "rename feeds" }
        ]
    }

    ListElement {
        version: "0.1.0"
        date: 1477643507000
        entries: [
            ListElement { type: 3; issue: ""; description: "first preview release"},
            ListElement { type: 0; issue: "1"; description: "folder list view" },
            ListElement { type: 0; issue: "7"; description: "folder list sorting"},
            ListElement { type: 0; issue: "3"; description: "delete folders"},
            ListElement { type: 0; issue: "2"; description: "create folders"},
            ListElement { type: 0; issue: "4"; description: "rename folders"},
            ListElement { type: 0; issue: "5"; description: "mark folder as read"}
        ]
    }
}

