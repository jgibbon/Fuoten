/* Fuoten - ownCloud/Nextcloud News App Client
 * Copyright (C) 2016-2019 Huessenbergnetz/Matthias Fehring
 * https://github.com/Huessenbergnetz/Fuoten
 *
 * sailfishos/qml/phone/pages/ArticlePage.qml
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
import harbour.fuoten.models 1.0
import harbour.fuoten.items 1.0
import "../../common/parts"

Page {
    id: articlePage

    property Article article: null
    property ContextConfig cc: null
    property ArticleListFilterModel articlesModel
    property int modelIndex
    onModelIndexChanged: {
        var newArticle = articlesModel.data(articlesModel.index(modelIndex, 0));
        if(newArticle) {
            article = newArticle;

            if (article.unread) {
                article.mark(false, true);
            }
            contentText.text = localstorage.getArticleBody(article.id);
            covercon.article = article;
            articleFlick.scrollToTop();
        }
    }

    property bool nextArticlePossible: modelIndex < articlesModel.rowCount()

    onStatusChanged: {
        if (status === PageStatus.Active) {
            if (!articlePage.canNavigateForward) {
                pageStack.pushAttached(Qt.resolvedUrl("WebViewPage.qml"), {article: article, isAttached: true, })
            }
        }
    }

    Component.onCompleted: {
        covercon.article = article
    }

    Component.onDestruction: {
        covercon.article = null;
    }

    SilicaFlickable {
        id: articleFlick
        anchors.fill: parent
        contentHeight: headerCol.height + contentText.height + Theme.paddingLarge

        VerticalScrollDecorator { page: articlePage; flickable: articleFlick }

        PullDownMenu {
            flickable: articleFlick
            busy: synchronizer.inOperation || (article && article.inOperation)
            MenuItem {
                text: article && article.starred
                        //: Menu entry for removing a single article from the favorites
                        //% "Remove from favorites"
                      ? qsTrId("fuoten-remove-from-favorites")
                        //: Menu entry for adding a single article to the favorites
                        //% "Add to favorites"
                      : qsTrId("fuoten-add-to-favorites")
                onClicked: article.star(!article.starred, config, localstorage, true)
                enabled: !article.inOperation
            }
            MenuItem {
                text: article && article.unread
                        //: Menu entry for marking a single article as read
                        //% "Mark as read"
                      ? qsTrId("fuoten-mark-item-as-read")
                        //: Menu entry for marking a single article as unread
                        //% "Mark as unread"
                      : qsTrId("fuoten-mark-item-as-unread")
                onClicked: article.mark(!article.unread, config, localstorage, true)
                enabled: !article.inOperation
            }
            MenuItem {
                //: Menu entry to share the link of an article
                //% "Share"
                text: qsTrId("fuoten-share")
                enabled: article
                onClicked: pageStack.push(Qt.resolvedUrl("../../common/pages/Sharing.qml"), {"shareUrl": article.url.toString(), "shareTitle": article.title })
            }
            MenuItem {
                //: Menu entry to open a single article in external browser
                //% "Open in browser"
                text: qsTrId("fuoten-open-in-browser")
                onClicked: Qt.openUrlExternally(article.url)
                enabled: article
            }
        }

        PushUpMenu {
            flickable: articleFlick
            visible: config.pushUpOnArticle
            MenuItem {
                //: Menu entry on the article page to go to the next article
                //% "Next Article"
                text: qsTrId("fuoten-go-to-next-article")
                enabled: articlePage.nextArticlePossible
                onClicked: {
                    modelIndex = modelIndex + 1;
                }
            }
            MenuItem {
                //: Menu entry on the article page to scroll back to the top of the page
                //% "Scroll to top"
                text: qsTrId("fuoten-scroll-to-top")
                visible: articleFlick.contentHeight > articleFlick.height
                onClicked: articleFlick.scrollToTop()
            }
            MenuItem {
                text: qsTrId("fuoten-share")
                enabled: article
                onClicked: pageStack.push(Qt.resolvedUrl("../../common/pages/Sharing.qml"), {"shareUrl": article.url.toString(), "shareTitle": article.title })
            }
            MenuItem {
                text: qsTrId("fuoten-open-in-browser")
                onClicked: Qt.openUrlExternally(article.url)
                enabled: article
            }
        }

        ColumnLayout {
            id: headerCol
            spacing: Theme.paddingSmall
            anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }

            PageHeader { page: articlePage; title: article ? article.feedTitle : ""; leftMargin: 0; rightMargin: 0; Layout.fillWidth: true }

            RowLayout {
                spacing: Theme.paddingSmall
                Layout.fillWidth: true

                Label {
                    Layout.fillWidth: true
                    text: article.title
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.PlainText
                    color: Theme.highlightColor
                }

                ColumnLayout {
                    Layout.preferredWidth: Theme.iconSizeSmall
                    Layout.alignment: Qt.AlignTop | Qt.AlignLeft

                    Image {
                        opacity: article.starred ? 1.0 : 0.0
                        Layout.preferredWidth: Theme.iconSizeSmall
                        Layout.preferredHeight: Theme.iconSizeSmall
                        source: "image://theme/icon-s-favorite"
                        Behavior on opacity { FadeAnimator{} }
                    }
                }
            }

            Row {
                spacing: Theme.paddingSmall
                Layout.fillWidth: true

                Text {
                    id: pdString
                    text: article.humanPubDate
                    font.pixelSize: Theme.fontSizeExtraSmall
                    textFormat: Text.PlainText
                    color: Theme.highlightColor
                }

                Text {
                    id: pdSep
                    text: "|"
                    font.pixelSize: Theme.fontSizeExtraSmall
                    textFormat: Text.PlainText
                    color: Theme.highlightColor
                }

                Text {
                    id: ptString
                    text: article.humanPubTime
                    font.pixelSize: Theme.fontSizeExtraSmall
                    textFormat: Text.PlainText
                    color: Theme.highlightColor
                }

                Text {
                    id: ptSep
                    text: "|"
                    font.pixelSize: Theme.fontSizeExtraSmall
                    textFormat: Text.PlainText
                    color: Theme.highlightColor
                    visible: article.author.length > 0
                }

                Label {
                    text: article.author
                    font.pixelSize: Theme.fontSizeExtraSmall
                    textFormat: Text.PlainText
                    color: Theme.highlightColor
                    truncationMode: TruncationMode.Fade
                    width: parent.width - pdString.width - pdSep.width - ptString.width - ptSep.width - (parent.spacing * 4)
                }
            }

            Separator {
                Layout.fillWidth: true
                color: Theme.primaryColor
            }
        }

        RescalingRichText {
            id: contentText
            anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: headerCol.bottom }
            color: Theme.primaryColor
            Component.onCompleted: text = localstorage.getArticleBody(article.id)
            onLinkActivated: Qt.openUrlExternally(link)
            fontSize: (config.articleFontSize > 0) ? config.articleFontSize : Theme.fontSizeSmall
        }
    }
}

