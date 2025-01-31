/* Fuoten - ownCloud/Nextcloud News App Client
 * Copyright (C) 2016-2019 Huessenbergnetz/Matthias Fehring
 * https://github.com/Huessenbergnetz/Fuoten
 *
 * sailfishos/src/sfosconfig.h
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

#ifndef SFOSCONFIG_H
#define SFOSCONFIG_H

#include "../../common/configuration.h"

class SfosConfig : public Configuration
{
    Q_OBJECT
    /*!
     * \brief This property holds \c true if a Push Up menu should be shown on article pages
     *
     * \par Access functions:
     * \li bool pushUpOnArticle() const
     * \li void setPushUpOnArticle(bool pushUpOnArticle)
     *
     * \par Notifier signal:
     * \li void pushUpOnArticleChanged
     */
    Q_PROPERTY(bool pushUpOnArticle READ pushUpOnArticle WRITE setPushUpOnArticle NOTIFY pushUpOnArticleChanged)
public:
    explicit SfosConfig(QObject *parent = nullptr);

    ~SfosConfig();

    QString getPassword() const override;
    void setPassword(const QString &password) override;

    /*!
     * \brief Getter function for the \link Configuration::pushUpOnArticle pushUpOnArticle \endlink property.
     * \sa setPushUpOnArticle(), pushUpOnArticleChanged()
     */
    bool pushUpOnArticle() const;
    /*!
     * \brief Setter function for the \link Configuration::pushUpOnArticle pushUpOnArticle \endlink property.
     * \sa pushUpOnArticle(), pushUpOnArticleChanged()
     */
    void setPushUpOnArticle(bool pushUpOnArticle);

    QString getUserAgent() const override;

signals:
    /*!
     * \brief Notification signal for the \link Configuration::pushUpOnArticle pushUpOnArticle \endlink property.
     * \sa pushUpOnArticle(), setPushUpOnArticle()
     */
    void pushUpOnArticleChanged(bool pushUpOnArticle);

private:
    QString encPw(const QString &pw) const;
    QString decPw(const QString &pw) const;

    QString m_password;
    bool m_pushUpOnArticle = false;
};

#endif // SFOSCONFIG_H
