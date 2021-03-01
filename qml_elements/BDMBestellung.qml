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
        /*gradient: Gradient {
            GradientStop { position: 0.0; color: '#D5D5D5'}
            GradientStop { position: 1.0; color: '#CDCBCB'}
        }*/
    }

    Connections {
        target: bestellungcontroller

        function onNutzerDatenAktualisiert(namensliste) {
            nameCB.model = namensliste;
        }
        function onAnzeigeDatenAktualiesieren(userdata) {
            console.log('konto ', userdata[0], 'mitglied ', userdata[1], 'bild ', userdata[2]);
            if (userdata[0] == '0.00') {
                txtKonto.color = 'red';
            }
            else {
                txtKonto.color = 'black';
            }
            txtKonto.text = 'Kontostand: ' + userdata[0];
            txtMitglied.text = userdata[1];
            profilbild.source = userdata[2];
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
            Layout.minimumWidth: parent.width/1.8
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
                        Text { text: preis; anchors.horizontalCenter: parent.horizontalCenter; anchors.top: pName.bottom}
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
                anchors.fill: parent
                cellWidth: parent.width / 3; cellHeight: parent.height / 3
                model: produktModel
                delegate: productDelegate          
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
            color: "blue"
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
                delegate: Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: name + "\t\t\t\t\t" + preis
                    font.pointSize: 12
                }

                Rectangle {
                    anchors.fill: parent
                    color: 'white'
                    border.width: 0.1
                    border.color: 'black'
                    z: -1

                    gradient: Gradient {
                        GradientStop { position: 0.8; color: 'white'}
                        GradientStop { position: 1.0; color: 'lightgrey'}
                    }
                    // ScrollView {
                    //     anchors.fill: parent
                    //     ScrollBar.vertical.interactive: true
                    //     ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                    //     ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                    // }
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
                                var count = bestellModel.rowCount()
                                console.log(count)
                                var i
                                for (i = count-1; i >= 0; i--) {
                                    console.log(i)
                                    bestellModel.deleteProdukt(i)
                                }
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
                                console.log(count)
                                var i
                                for (i = count-1; i >= 0; i--) {
                                    console.log(i)
                                    bestellModel.deleteProdukt(i)
                                }
                                var konto = txtKonto.text.replace("Kontostand:", "")
                                console.log(konto)
                                var neuKonto = eval(konto - endsumme.text)
                                txtKonto.text = 'Kontostand: ' + neuKonto
                                endsumme.text = '0.00'
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
                                var count = bestellModel.rowCount()
                                console.log(count)
                                var i
                                for (i = count-1; i >= 0; i--) {
                                    console.log(i)
                                    bestellModel.deleteProdukt(i)
                                }
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
                                var count = bestellModel.rowCount()
                                console.log(count)
                                var i
                                for (i = count-1; i >= 0; i--) {
                                    console.log(i)
                                    bestellModel.deleteProdukt(i)
                                }
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