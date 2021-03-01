import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Pane {
    padding: 0
    background: Rectangle {
        anchors.fill: parent
    }
    
    Component {
        id: contactDelegate
        Item {
            width: gridview.cellWidth; height: gridview.cellHeight
            Grid {
                anchors.fill: parent
                columns: 2
                spacing: 2
                Image { id: pIm; source: portrait; anchors.horizontalCenter: parent.horizontalCenter; anchors.verticalCenter: parent.verticalCenter}
                Text { id: pName; text: name; anchors.horizontalCenter: parent.horizontalCenter; anchors.top: pIm.bottom}
                TextField { text: "Text"; cursorVisible: false; anchors.left: pName.right; anchors.top: pIm.bottom; anchors.leftMargin: 20}
                Text { id: pPreis; text: preis; anchors.horizontalCenter: parent.horizontalCenter; anchors.top: pName.bottom}
                TextField { text: "Text"; cursorVisible: false; anchors.left: pPreis.right; anchors.top: pName.bottom; anchors.leftMargin: 20}
            }
        }
    }

    GridView {
        id: gridview
        header: produktHeading
        anchors.fill: parent
        cellWidth: parent.width / 3; cellHeight: parent.height / 3
        model: produktModel
        delegate: contactDelegate         
    }
}