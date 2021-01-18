import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Pane {
    padding: 0
    background: Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: '#ff464c57'}
            GradientStop { position: 1.0; color: '#ff393e47'}
        }
    }

    Connections {
        target: bestellungcontroller

        function onNutzerDatenAktualisiert(namensliste) {
            name.model = namensliste;
        }
        function onAnzeigeDatenAktualiesieren(konto, mitglied) {
            //console.log('konto ', konto, 'mitglied ', mitglied );
            if (konto == '0.00') {
                txtKonto.color = 'red';
            }
            txtKonto.text = 'Kontostand: ' + konto;
            txtMitglied.text = mitglied;
        }
    }

    GridLayout {
        id: grid
        anchors.fill: parent
        rows: 6
        columns: 3

        Rectangle {
            color: "red"
            Layout.fillHeight: true
            Layout.minimumWidth: parent.width/1.8
            Layout.columnSpan: 1
            Layout.rowSpan: 6
            Layout.row: 0
            Layout.column: 0

            ScrollView {
                anchors.fill: parent
                ScrollBar.vertical.interactive: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                ListView {
                    id: listView
                    //model: bestellungsmodel
                    anchors.fill: parent
                    interactive: true
                    clip: true
                    header: produktHeading

                    Rectangle {
                        anchors.fill: parent
                        border.width: 0.1
                        border.color: 'black'
                        z: -1
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: 'white'}
                            GradientStop { position: 1.0; color: '#ff393e47'}
                        }
                    }
                }
            }
        }

        Rectangle {
            color: "blue"
            Layout.minimumHeight: parent.height/2
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 0
            Layout.column: 1

            ScrollView {
                anchors.fill: parent
                ScrollBar.vertical.interactive: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                ListView {
                    id: kassenzettelListe
                    //model: kassenzettelmodel
                    anchors.fill: parent
                    interactive: true
                    clip: true

                    Rectangle {
                        anchors.fill: parent
                        color: 'white'
                        border.width: 0.1
                        border.color: 'black'
                        z: -1
                    }
                }
            }
        }

        Rectangle {
            color: "green"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 1
            Layout.column: 1

            ComboBox {
                id: name
                anchors.fill: parent
                editable: false
                model: nutzerliste
                onCurrentIndexChanged: {
                    bestellungcontroller.getCurrentCBData(currentIndex)
                }
                Component.onCompleted: {
                    bestellungcontroller.getUsers()
                }
            }
        }

        Rectangle {
            color: "yellow"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 2
            Layout.row: 2
            Layout.column: 1
        }

        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 2

            Text {
                id: txtKonto
                anchors.fill: parent
                anchors.left: parent.left
                anchors.topMargin: parent.height/2-6
                anchors.leftMargin: 10
                font.family: "fontawsome"
                font.pointSize: 12
                font.bold: true
                color: "black"
            }
        }

        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 2

            Text {
                id: txtMitglied
                anchors.fill: parent
                anchors.left: parent.left
                anchors.topMargin: parent.height/2-6
                anchors.leftMargin: 10
                font.family: "fontawsome"
                font.pointSize: 12
                font.bold: true
                color: "black"
            }
        }

        Rectangle {
            color: "blue"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 4
            Layout.column: 1
        }

        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 1
        }

        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 2
        }
    }

    Component {
        id: produktHeading
        Rectangle {
            border {color: "black"; width: 5}
            width: parent.width; height: 50

            Text {
                text: "Produkte"
                font.family: "fontawsome"
                font.pointSize: 24
                color: "black"
                anchors.centerIn: parent
            }
        }
    }
}