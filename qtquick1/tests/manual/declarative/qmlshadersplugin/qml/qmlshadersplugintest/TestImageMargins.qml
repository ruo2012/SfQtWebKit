/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the test suite of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL21$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file. Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** As a special exception, The Qt Company gives you certain additional
** rights. These rights are described in The Qt Company LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 1.0
import Qt.labs.shaders 1.0

Rectangle {
    id: imageMarginTester
    anchors.fill: parent;
    color: "green"
    property real testMarginX: 10
    property real testMarginY: 10

    Timer {
        running: true
        interval: 2000
        repeat: true

        onTriggered: {
            if (imageMarginTester.testMarginX < 20) {
                imageMarginTester.testMarginX = 50
                imageMarginTester.testMarginY = 120
            }
            else {
                imageMarginTester.testMarginX = 10
                imageMarginTester.testMarginY = 10
            }

            console.log("onTriggered...")
            theSource.sourceRect = Qt.rect(-testMarginX, -testMarginY, parent.width + testMarginX*2, parent.height + testMarginY*2)
            console.log("onTriggered done")
        }
    }

    ShaderEffectSource {
        id: theSource
        sourceImage: "image_opaque.png"
        sourceRect: Qt.rect(-10,-10, parent.width + 2*10, parent.height + 2*10)
        hideSource: true
    }

    ShaderEffectItem {
        id: effect
        anchors.fill: parent;
        property variant source: theSource
    }

    Rectangle {
        width: parent.width
        height: 40
        color: "#cc000000"

        Text {
             id: label
             anchors.centerIn:  parent
             text: theSource.sourceRect.width == 0 ? "No margins" : "Green margins " + imageMarginTester.testMarginX + "x" + imageMarginTester.testMarginY
             color: "white"
             font.bold: true
        }
    }
}
