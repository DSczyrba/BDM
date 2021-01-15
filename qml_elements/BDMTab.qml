import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Pane {
    id:bdmTab
    padding:0

    background: Rectangle {
        anchors.fill: parent
    }

    TabBar {
        id: bar
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        background: Rectangle {
            anchors.fill: parent
        }

        TabButton {
            id: bestellung

            contentItem: Text {
                text: "Bestellung"
                font.pointSize: bestellung.checked ? 16:14
                font.family: "fontawsome"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: bestellung.checked ? "#dcdcdc" : "#f8f8ff"
                opacity: enabled ? 1 : 0.3
            }
        }

        TabButton {
            id: kassenzettel

            contentItem: Text {
                text: "Kassenzettel"
                font.pointSize: kassenzettel.checked ? 16:14
                font.family: "fontawsome"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: kassenzettel.checked ? "#dcdcdc" : "#f8f8ff"
                opacity: enabled ? 1 : 0.3
            }
        }

        TabButton {
            id: historie

            contentItem: Text {
                text: "Historie"
                font.pointSize: historie.checked ? 16:14
                font.family: "fontawsome"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: historie.checked ? "#dcdcdc" : "#f8f8ff"
                opacity: enabled ? 1 : 0.3
            }
        }

        TabButton {
            id: nutzerverwaltung

            contentItem: Text {
                text: "Nutzerverwaltung"
                font.pointSize: nutzerverwaltung.checked ? 16:14
                font.family: "fontawsome"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: nutzerverwaltung.checked ? "#dcdcdc" : "#f8f8ff"
                opacity: enabled ? 1 : 0.3
            }
        }

        TabButton {
            id: artikelverwaltung

            contentItem: Text {
                text: "Artikelverwaltung"
                font.pointSize: artikelverwaltung.checked ? 16:14
                font.family: "fontawsome"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: artikelverwaltung.checked ? "#dcdcdc" : "#f8f8ff"
                opacity: enabled ? 1 : 0.3
            }
        }
    }

    StackLayout {
        id: tabLayout
        anchors.top: bar.bottom
        anchors.bottom: parent.bottom
        anchors.left: bar.left
        anchors.right: bar.right
        currentIndex: bar.currentIndex

        BDMBestellung {
            id: bestellungTab
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
        }

        BDMKassenzettel {
            id: kassenzettelTab
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
        }

        BDMHistorie {
            id: historieTab
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
        }

        BDMNutzerverwaltung {
            id: nutzerverwaltungTab
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
        }

        BDMArtikelverwaltung {
            id: artikelverwaltungTab
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
        }
    }
}
