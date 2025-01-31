/* Fuoten - ownCloud/Nextcloud News App Client
 * Copyright (C) 2016-2019 Huessenbergnetz/Matthias Fehring
 * https://github.com/Huessenbergnetz/Fuoten
 *
 * common/contextconfig.cpp
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

#include "contextconfig.h"
#include <QMetaEnum>

#define CONF_KEY_USERAGENTIDX "userAgentIdx"
#define CONF_KEY_USERAGENT "userAgent"
#define CONF_KEY_MINFONTSIZE "minimumFontSize"
#define CONF_KEY_DEFFONTSIZE "defaultFontSize"

/*!
 * \brief Constructs a new ContextConfig object.
 */
ContextConfig::ContextConfig(QObject *parent) :
    QSettings(parent)
{
    m_contextType = FuotenAppEnums::StartPage;
    m_contextId = -1;
    m_sorting = (Fuoten::FuotenEnums::SortingRole)value(path(QStringLiteral("sorting")), Fuoten::FuotenEnums::Name).toInt();
    m_hideRead = value(path(QStringLiteral("hideRead")), false).toBool();
    m_sortOrder = (Qt::SortOrder)value(path(QStringLiteral("sortOrder")), Qt::AscendingOrder).toInt();
    m_showFolderSections = value(path(QStringLiteral("showFolderSections")), false).toBool();
    m_respectPinned = value(path(QStringLiteral("respectPinned")), true).toBool();
    m_showExcerpt = value(path(QStringLiteral("showExcerpt")), false).toBool();
    m_openArticles = (FuotenAppEnums::OpenIn)value(path(QStringLiteral("openArticles")), FuotenAppEnums::OpenInternal).toInt();
    m_deletionStrategy = (Fuoten::FuotenEnums::ItemDeletionStrategy)value(path(QStringLiteral("deletionStrategy")), Fuoten::FuotenEnums::DeleteItemsByTime).toInt();
    m_deletionValue = value(path(QStringLiteral("deletionValue")), 14).value<quint16>();
    m_userAgentIdx = value(path(QStringLiteral(CONF_KEY_USERAGENTIDX)), m_userAgentIdx).value<quint8>();
    m_userAgent = value(path(QStringLiteral(CONF_KEY_USERAGENT)), m_userAgent).toString();
    m_minimumFontSize = value(path(QStringLiteral(CONF_KEY_MINFONTSIZE)), m_minimumFontSize).toInt();
    m_defaultFontSize = value(path(QStringLiteral(CONF_KEY_DEFFONTSIZE)), m_defaultFontSize).toInt();
}


/*!
 * \brief Deconstructs the ContextConfig object.
 */
ContextConfig::~ContextConfig()
{
}


void ContextConfig::load()
{
    setSorting((Fuoten::FuotenEnums::SortingRole)value(path(QStringLiteral("sorting")), Fuoten::FuotenEnums::Name).toInt());
    setHideRead(value(path(QStringLiteral("hideRead")), false).toBool());
    setSortOrder((Qt::SortOrder)value(path(QStringLiteral("sortOrder")), m_contextType < FuotenAppEnums::AllItems ? Qt::AscendingOrder : Qt::DescendingOrder).toInt());
    setShowFolderSections(value(path(QStringLiteral("showFolderSections")), true).toBool());
    setRespectPinned(value(path(QStringLiteral("respectPinned")), true).toBool());
    setShowExcerpt(value(path(QStringLiteral("showExcerpt")), false).toBool());
    setOpenArticles((FuotenAppEnums::OpenIn)value(path(QStringLiteral("openArticles")), FuotenAppEnums::OpenInternal).toInt());
    setDeletionStrategy((Fuoten::FuotenEnums::ItemDeletionStrategy)value(path(QStringLiteral("deletionStrategy")), Fuoten::FuotenEnums::DeleteItemsByTime).toInt());
    setDeletionValue(value(path(QStringLiteral("deletionValue")), 14).value<quint16>());
    setUserAgentIdx(value(path(QStringLiteral(CONF_KEY_USERAGENTIDX)), 0).value<quint8>());
    setUserAgent(value(path(QStringLiteral(CONF_KEY_USERAGENT)), m_userAgent).toString());
    setMinimumFontSize(value(path(QStringLiteral(CONF_KEY_MINFONTSIZE)), m_minimumFontSize).toInt());
    setDefaultFontSize(value(path(QStringLiteral(CONF_KEY_DEFFONTSIZE)), m_defaultFontSize).toInt());
}


FuotenAppEnums::Context ContextConfig::contextType() const { return m_contextType; }

void ContextConfig::setContextType(FuotenAppEnums::Context nContextType)
{
    if (nContextType != m_contextType) {
        m_contextType = nContextType;
        qDebug("Changed contextType to %s.", FuotenAppEnums::staticMetaObject.enumerator(FuotenAppEnums::staticMetaObject.indexOfEnumerator("Context")).valueToKey(m_contextType));
        emit contextTypeChanged(contextType());
        load();
    }
}


qint64 ContextConfig::contextId() const { return m_contextId; }

void ContextConfig::setContextId(qint64 nId)
{
    if (nId != m_contextId) {
        m_contextId = nId;
        qDebug("Changed id to %lli.", m_contextId);
        emit contextIdChanged(contextId());
        load();
    }
}


Fuoten::FuotenEnums::SortingRole ContextConfig::sorting() const { return m_sorting; }

void ContextConfig::setSorting(Fuoten::FuotenEnums::SortingRole nSorting)
{
    if (nSorting != m_sorting) {
        m_sorting = nSorting;
        qDebug("Changed sorting to %s.", Fuoten::FuotenEnums::staticMetaObject.enumerator(Fuoten::FuotenEnums::staticMetaObject.indexOfEnumerator("SortingRole")).valueToKey(m_sorting));
        setValue(path(QStringLiteral("sorting")), m_sorting);
        emit sortingChanged(sorting());
    }
}


bool ContextConfig::hideRead() const { return m_hideRead; }

void ContextConfig::setHideRead(bool nHideRead)
{
    if (nHideRead != m_hideRead) {
        m_hideRead = nHideRead;
        qDebug("Changed hideRead to %s.", m_hideRead ? "true" : "false");
        setValue(path(QStringLiteral("hideRead")), m_hideRead);
        emit hideReadChanged(hideRead());
    }
}


Qt::SortOrder ContextConfig::sortOrder() const { return m_sortOrder; }

void ContextConfig::setSortOrder(Qt::SortOrder nSortOrder)
{
    if (nSortOrder != m_sortOrder) {
        m_sortOrder = nSortOrder;
        qDebug("Changed sortOrder to %i.", m_sortOrder);
        setValue(path(QStringLiteral("sortOrder")), m_sortOrder);
        emit sortOrderChanged(sortOrder());
    }
}

bool ContextConfig::showFolderSections() const { return m_showFolderSections; }

void ContextConfig::setShowFolderSections(bool nShowFolderSections)
{
    if (nShowFolderSections != m_showFolderSections) {
        m_showFolderSections = nShowFolderSections;
        qDebug("Changed showFolderSections to %s.", m_showFolderSections ? "true" : "false");
        setValue(path(QStringLiteral("showFolderSections")), m_showFolderSections);
        emit showFolderSectionsChanged(showFolderSections());
    }
}

bool ContextConfig::respectPinned() const { return m_respectPinned; }

void ContextConfig::setRespectPinned(bool nRespectPinned)
{
    if (nRespectPinned != m_respectPinned) {
        m_respectPinned = nRespectPinned;
        qDebug("Changed respectPinned to %s.", m_respectPinned ? "true" : "false");
        setValue(path(QStringLiteral("respectPinned")), m_respectPinned);
        emit respectPinnedChanged(respectPinned());
    }
}


bool ContextConfig::showExcerpt() const { return m_showExcerpt; }

void ContextConfig::setShowExcerpt(bool nShowExcerpt)
{
    if (nShowExcerpt != m_showExcerpt) {
        m_showExcerpt = nShowExcerpt;
        qDebug("Changed showExcerpt to %s.", m_showExcerpt ? "true" : "false");
        setValue(path(QStringLiteral("showExcerpt")), m_showExcerpt);
        Q_EMIT showExcerptChanged(showExcerpt());
    }
}


FuotenAppEnums::OpenIn ContextConfig::openArticles() const { return m_openArticles; }

void ContextConfig::setOpenArticles(FuotenAppEnums::OpenIn nOpenArticles)
{
    if (nOpenArticles != m_openArticles) {
        m_openArticles = nOpenArticles;
        qDebug("Changed openArticles to %s.", FuotenAppEnums::staticMetaObject.enumerator(FuotenAppEnums::staticMetaObject.indexOfEnumerator("OpenIn")).valueToKey(m_openArticles));
        setValue(path(QStringLiteral("openArticles")), m_openArticles);
        Q_EMIT openArticlesChanged(openArticles());
    }
}


Fuoten::FuotenEnums::ItemDeletionStrategy ContextConfig::deletionStrategy() const { return m_deletionStrategy; }

void ContextConfig::setDeletionStrategy(Fuoten::FuotenEnums::ItemDeletionStrategy nDeletionStrategy)
{
    if (nDeletionStrategy != m_deletionStrategy) {
        m_deletionStrategy = nDeletionStrategy;
        qDebug("Changed deletionStrategy to %s.", Fuoten::FuotenEnums::staticMetaObject.enumerator(Fuoten::FuotenEnums::staticMetaObject.indexOfEnumerator("ItemDeletionStrategy")).valueToKey(m_deletionStrategy));
        setValue(path(QStringLiteral("deletionStrategy")), m_deletionStrategy);
        Q_EMIT deletionStrategyChanged(deletionStrategy());
    }
}


quint16 ContextConfig::deletionValue() const { return m_deletionValue; }

void ContextConfig::setDeletionValue(quint16 nDeletionValue)
{
    if (nDeletionValue != m_deletionValue) {
        m_deletionValue = nDeletionValue;
        qDebug("Changed deletion value to %i.", m_deletionValue);
        setValue(path(QStringLiteral("deletionValue")), m_deletionValue);
        Q_EMIT deletionValueChanged(deletionValue());
    }
}


quint8 ContextConfig::userAgentIdx() const { return m_userAgentIdx; }

void ContextConfig::setUserAgentIdx(quint8 nUserAgentIdx)
{
    if (nUserAgentIdx != m_userAgentIdx) {
        m_userAgentIdx = nUserAgentIdx;
        qDebug("Changed userAgentIdx to %u.", m_userAgentIdx);
        setValue(path(QStringLiteral(CONF_KEY_USERAGENTIDX)), m_userAgentIdx);
        Q_EMIT userAgentIdxChanged(m_userAgentIdx);
    }
}


QString ContextConfig::userAgent() const { return m_userAgent; }

void ContextConfig::setUserAgent(const QString &nUserAgent)
{
    if (nUserAgent != m_userAgent) {
        m_userAgent = nUserAgent;
        qDebug("Changed userAgent to \"%s\".", qUtf8Printable(m_userAgent));
        setValue(path(QStringLiteral(CONF_KEY_USERAGENT)), m_userAgent);
        Q_EMIT userAgentChanged(m_userAgent);
    }
}


int ContextConfig::minimumFontSize() const { return m_minimumFontSize; }

void ContextConfig::setMinimumFontSize(int minimumFontSize)
{
    if (minimumFontSize != m_minimumFontSize) {
        m_minimumFontSize = minimumFontSize;
        qDebug("Changed minimumFontSize to %i.", m_minimumFontSize);
        setValue(path(QStringLiteral(CONF_KEY_MINFONTSIZE)), m_minimumFontSize);
        Q_EMIT minimumFontSizeChanged(m_minimumFontSize);
    }
}


int ContextConfig::defaultFontSize() const { return m_defaultFontSize; }

void ContextConfig::setDefaultFontSize(int defaultFontSize)
{
    if (defaultFontSize != m_defaultFontSize) {
        m_defaultFontSize = defaultFontSize;
        qDebug("Changed defaultFontSize to %i.", m_defaultFontSize);
        setValue(path(QStringLiteral(CONF_KEY_DEFFONTSIZE)), m_defaultFontSize);
        Q_EMIT defaultFontSizeChanged(m_defaultFontSize);
    }
}


QString ContextConfig::path(const QString &key) const
{
    if (key.isEmpty()) {
        return key;
    }

    switch (contextType()) {
    case FuotenAppEnums::StartPage:
        return QStringLiteral("StartPage/%1").arg(key);
    case FuotenAppEnums::Folders:
        return QStringLiteral("Folders_%1/%2").arg(QString::number(contextId()), key);
    case FuotenAppEnums::Feeds:
        return QStringLiteral("Feeds_%1/%2").arg(QString::number(contextId()), key);
    case FuotenAppEnums::AllItems:
        return QStringLiteral("AllItems/%1").arg(key);
    case FuotenAppEnums::FolderItems:
        return QStringLiteral("FolderItems_%1/%2").arg(QString::number(contextId()), key);
    case FuotenAppEnums::FeedItems:
        return QStringLiteral("FeedItems_%1/%2").arg(QString::number(contextId()), key);
    case FuotenAppEnums::StarredItems:
        return QStringLiteral("StarredItems_%1/%2").arg(QString::number(contextId()), key);
    case FuotenAppEnums::SingleItem:
        return QStringLiteral("Item_%1/%2").arg(QString::number(contextId()), key);
    default:
        return key;
    }
}

#include "moc_contextconfig.cpp"
