/* Fuoten - ownCloud/Nextcloud News App Client
 * Copyright (C) 2016-2019 Huessenbergnetz/Matthias Fehring
 * https://github.com/Huessenbergnetz/Fuoten
 *
 * sailfishos/src/dbus/fuotendbusadaptor.cpp
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

#include "fuotendbusadaptor.h"

FuotenDbusAdaptor::FuotenDbusAdaptor(QObject *parent) : QDBusAbstractAdaptor(parent)
{

}


FuotenDbusAdaptor::~FuotenDbusAdaptor()
{

}


void FuotenDbusAdaptor::activate()
{
    qDebug("Activating main window via D-Bus.");
    const bool ret = QMetaObject::invokeMethod(parent(), "activate");
    Q_ASSERT(ret);
}
