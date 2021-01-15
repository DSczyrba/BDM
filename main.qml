import QtQuick.Window 2.2
import QtQuick 2.3
import "qml_elements"

Window {
    visible: true
    width: 1280
    minimumWidth: 1280
    height: 720
    minimumHeight: 720
    title: "BDM"

    BDMTab {
        id: tab
        z:1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
}