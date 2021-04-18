import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12

Pane {
    padding: 0
    background: Rectangle {
        anchors.fill: parent
        color: "white"
    }
    Rectangle {
            color: 'black'
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2-1
            width: 3
            height: parent.height - 50
        }

    Connections {
        target: bestellungcontroller

        function onNutzerDatenAktualisiert(namensliste) {
            nameCB.model = namensliste;
        }
        function onAnzeigeDatenAktualiesieren(userdata) {
            console.log('konto ', userdata[0], 'mitglied ', userdata[1], 'bild ', userdata[2]);
            if ((userdata[0] == '0.00€') || (userdata[0].includes('-'))) {
                txtKonto.color = 'red';
            }
            else {
                txtKonto.color = 'black';
            }
            txtKonto.text = 'Kontostand: ' + userdata[0];
            txtMitglied.text = userdata[1];
            profilbild.source = userdata[2];
            artikelcontroller.getArtikel(userdata[1])
        }
        function onCbIndexAktualisieren(index) {
            nameCB.currentIndex = index;
        }
    }

    GridLayout {
        id: grid
        anchors.fill: parent
        rows: 6
        columns: 3

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width/2
            Layout.columnSpan: 1
            Layout.rowSpan: 6
            Layout.row: 0
            Layout.column: 0

            Component {
                id: productDelegate
                Item {
                    width: gridview.cellWidth; height: gridview.cellHeight
                    Column {
                        anchors.fill: parent
                        Image { id: pIm; source: portrait; anchors.horizontalCenter: parent.horizontalCenter; anchors.verticalCenter: parent.verticalCenter}
                        Text { id: pName; text: name; anchors.horizontalCenter: parent.horizontalCenter; anchors.top: pIm.bottom }
                        Text { id : pPreis; text: preis; anchors.horizontalCenter: parent.horizontalCenter; anchors.top: pName.bottom}
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log('moin', model.name, model.preis)
                                bestellModel.addProdukt(model.name, model.preis)
                                var fEndsumme = endsumme.text.replace('€', '')
                                var summe = parseFloat(fEndsumme) + parseFloat(model.preis)
                                endsumme.text = summe
                            }
                        }
                    }
                }
            }

            GridView {
                id: gridview
                header: produktHeading
                clip: true
                anchors.fill: parent
                cellWidth: parent.width / 3; cellHeight: parent.height / 3
                model: produktModel
                delegate: productDelegate

                Component.onCompleted: {
                    //artikelcontroller.getArtikel()
                }           
            }


            // ListModel {
            //     id: contactModel
            //     ListElement {
            //         name: "Eric"
            //         preis: "1.50€"
            //         portrait: "src/beer-icon.png"
            //     }
            //     ListElement {
            //         name: "Dominic"
            //         preis: "1.50€"
            //         portrait: "src/beer-icon.png"
            //     }
            // }

            // ListView {
            //     id: listView
            //     //model: bestellungsmodel
            //     anchors.fill: parent
            //     interactive: true
            //     clip: true
            //     header: produktHeading

            //     Rectangle {
            //         anchors.fill: parent
            //         border.width: 0.1
            //         border.color: 'black'
            //         z: -1
            //         gradient: Gradient {
            //             GradientStop { position: 0.6; color: 'white'}
            //             GradientStop { position: 1.0; color: 'lightgrey'}

            //         }
            //         ScrollView {
            //             anchors.fill: parent
            //             ScrollBar.vertical.interactive: true
            //             ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            //             ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            //         }
            //     }
            // }
        }

        Rectangle {
            Layout.minimumHeight: parent.height/2
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 0
            Layout.column: 1

            ListView {
                id: bestellListe
                //model: kassenzettelmodel
                anchors.fill: parent
                interactive: true
                clip: true
                model: bestellModel
                header: kassenHeading
                delegate: bestellungDelegate

                Component {
                    id: bestellungDelegate
                    Item {
                        width: bestellListe.width; height: 20
                        Grid {
                            anchors.fill: parent
                            columns: 2
                            spacing: 2
                            Text { id: pName; font.pointSize: 12; text: name; anchors.left: parent.left; anchors.leftMargin: 100; anchors.top: parent.top; anchors.topMargin: 5}
                            Text { id: pPreis; font.pointSize: 12; text: preis; anchors.left: pName.left; anchors.leftMargin: bestellListe.width / 3 - width; anchors.top: parent.top; anchors.topMargin: 5}
                            Button { anchors.left: pPreis.left; anchors.top: parent.top; height: 15; text: "Löschen"; anchors.leftMargin: bestellListe.width / 2 - width; anchors.topMargin: 5
                                onClicked: {
                                    bestellModel.deleteProdukt(model.index)
                                    var ProPreis = pPreis.text.replace("€", "")
                                    var endSum = eval(endsumme.text - ProPreis)
                                    endsumme.text = endSum
                                }
                            }
                        }
                    }
                }
            }
        }
        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 1
            Layout.column: 1
            border {color: "black"; width: 1}

            Text {
                id: lblSumme
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: parent.height/2-8
                anchors.leftMargin: 10
                font.family: "fontawsome"
                font.pointSize: 12
                font.bold: true
                color: "black"
                width: parent.width/2
                text: "Summe:"
            }
            Text {
                id: endsumme
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: parent.height/2-8
                anchors.rightMargin: 10
                font.family: "fontawsome"
                font.pointSize: 12
                font.bold: true
                color: "black"
                text: "0.00"
            }
        }

        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 1

            ComboBox {
                id: nameCB
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
            Layout.row: 3
            Layout.column: 1

            Image {
                id: profilbild
                anchors.fill: parent
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

            DropShadow {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.fill: parent
                horizontalOffset: -3
                verticalOffset: 3
                radius: 0
                samples: 17
                color: "#80000000"

                Rectangle {
                anchors.fill: parent
                color: "white"
                }
            }

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
            Layout.row: 4
            Layout.column: 2

            DropShadow {
                anchors.fill: parent
                horizontalOffset: -3
                verticalOffset: 3
                radius: 0
                samples: 17
                color: "#80000000"

                Rectangle {
                anchors.fill: parent
                color: "white"

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
            }
        }

        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 1

            Button {
                id: listeBtn
                anchors.fill: parent
                text: "Liste"
                onClicked: popup1.open()
            }
            Popup {
                id: popup1

                parent: Overlay.overlay

                x: Math.round((parent.width - width) / 2)
                y: Math.round((parent.height - height) / 2)
                width: 500
                height: 100

                GridLayout {
                    anchors.fill: parent
                    rows: 2
                    columns: 2

                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.rowSpan: 1
                        Layout.row: 0
                        Layout.column: 0

                        Text {text: "Auf Liste schreiben?"}
                    }

                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.columnSpan: 1
                        Layout.rowSpan: 1
                        Layout.row: 1
                        Layout.column: 0

                        Button {
                            anchors.fill: parent
                            text: "Abbrechen"
                            onClicked: {
                                popup1.close()
                            }
                        }
                    }
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.columnSpan: 1
                        Layout.rowSpan: 1
                        Layout.row: 1
                        Layout.column: 1

                        Button {
                            anchors.fill: parent
                            text: "Ok"
                            onClicked: {
                                popup1.close()
                                var count = bestellModel.rowCount()
                                var i
                                for (i = count-1; i >= 0; i--) {
                                    bestellModel.deleteProdukt(i)
                                }
                                var konto = txtKonto.text.replace("Kontostand:", "")
                                konto = konto.replace("€", "")
                                var neuKonto = eval(konto - endsumme.text)
                                endsumme.text = '0.00'
                                bestellungcontroller.pay(nameCB.currentIndex, neuKonto)
                                bestellungcontroller.getUsers()
                                bestellungcontroller.getCurrentCBData(nameCB.currentIndex)
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 2

            Button {
                id: barBtn
                anchors.fill: parent
                text: "Bar"
                onClicked: popup.open()
            }

            Popup {
                id: popup

                parent: Overlay.overlay

                x: Math.round((parent.width - width) / 2)
                y: Math.round((parent.height - height) / 2)
                width: 500
                height: 100

                GridLayout {
                    anchors.fill: parent
                    rows: 2
                    columns: 2

                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.rowSpan: 1
                        Layout.row: 0
                        Layout.column: 0

                        Text {text: "Soll wirklich bar bezahlt werden?"}
                    }

                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.columnSpan: 1
                        Layout.rowSpan: 1
                        Layout.row: 1
                        Layout.column: 0

                        Button {
                            anchors.fill: parent
                            text: "Abbrechen"
                            onClicked: {
                                popup.close()
                            }
                        }
                    }
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.columnSpan: 1
                        Layout.rowSpan: 1
                        Layout.row: 1
                        Layout.column: 1

                        Button {
                            anchors.fill: parent
                            text: "Ok"
                            onClicked: {
                                popup.close()
                                bestellungcontroller.payBar(endsumme.text)
                                var count = bestellModel.rowCount()
                                var i
                                for (i = count-1; i >= 0; i--) {
                                    bestellModel.deleteProdukt(i)
                                }
                                endsumme.text = '0.00'
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: produktHeading
        Rectangle {
            //border {color: "black"; width: 5}
            width: parent.width
            height: 50
            color: "white"

            DropShadow {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.fill: parent
                horizontalOffset: 3
                verticalOffset: 3
                radius: 8.0
                samples: 17
                color: "#80000000"

                Rectangle {
                anchors.fill: parent
                color: "white"

                    Text {
                        text: "Produkte"
                        font.family: "fontawsome"
                        font.pointSize: 24
                        color: "black"
                        anchors.centerIn: parent
                        font.bold: true
                    }
                }
            }
        }
    }

    Component {
        id: kassenHeading
        Rectangle {
            //border {color: "black"; width: 5}
            width: parent.width
            height: 50
            color: "white"

            DropShadow {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.fill: parent
                horizontalOffset: 3
                verticalOffset: 3
                radius: 8.0
                samples: 17
                color: "#80000000"

                Rectangle {
                anchors.fill: parent
                color: "white"

                    Text {
                        text: "Bestellung"
                        font.family: "fontawsome"
                        font.pointSize: 24
                        color: "black"
                        anchors.centerIn: parent
                        font.bold: true
                    }
                }
            }
        }
    }
}