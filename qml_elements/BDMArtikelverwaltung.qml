import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Pane {
    padding: 0
    background: Rectangle {
        anchors.fill: parent
    }
    ScrollView {
        anchors.fill: parent
        ScrollBar.vertical.interactive: true
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        ScrollBar.horizontal.policy: ScrollBal.AlwaysOff

        ListView {
            id: productView
            model: produktListe
            boundsBehavior: Flickable.StopAtBounds
            interactive: false
            spacing: 5
            clip: true

            Rectangle {
                anchors.fill: parent
                color: "white"
                border.width: 0.2
                border.color: "black"
                z: -1
            }
            delegate: BDMProdukt {
                propLVModel: model.valueList
                Binding {
                   target: model
                   property: "valueList"
                   value: propLVModel
                }
            }
        }
    }
}