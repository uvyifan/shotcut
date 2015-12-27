/*
 * Copyright (c) 2015 Meltytech, LLC
 * Author: Dan Dennedy <dan@dennedy.org>
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
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import Shotcut.Controls 1.0
import QtQml.Models 2.2

Item {
    width: 200
    height: 50
    property string paramDisplay: '0'
    property string paramUseInput: '1'
    Component.onCompleted: {
        if (filter.isNew) {
            filter.set(paramUseInput, 1)
            filter.set(paramDisplay, 0.21)
        }
        var current = filter.getDouble(paramDisplay)
        for (var i = 0; i < displayModel.count; ++i) {
            if (displayModel.get(i).value === current) {
                displayCombo.currentIndex = i
                break
            }
        }
    }
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 8

        RowLayout {
            Label { text: qsTr('Display') }
            ComboBox {
                id: displayCombo
                implicitWidth: 180
                model: ListModel {
                    id: displayModel
                    ListElement { text: qsTr('Gray Alpha'); value: 0.21 }
                    ListElement { text: qsTr('Red & Gray Alpha'); value: 0.36 }
                    ListElement { text: qsTr('Checkered Background'); value: 1.00 }
                    ListElement { text: qsTr('Black Background'); value: 0.50 }
                    ListElement { text: qsTr('Gray Background'); value: 0.64 }
                    ListElement { text: qsTr('White Background'); value: 0.79 }
                }
                onCurrentIndexChanged: {
                    filter.set(paramDisplay, displayModel.get(currentIndex).value)
                }
            }
        }
        Item { Layout.fillHeight: true }
    }
}

