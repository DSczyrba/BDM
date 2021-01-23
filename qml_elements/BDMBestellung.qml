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
            name.model = namensliste;
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
                        GradientStop { position: 0.6; color: 'white'}
                        GradientStop { position: 1.0; color: 'lightgrey'}

                    }
                    ScrollView {
                        anchors.fill: parent
                        ScrollBar.vertical.interactive: true
                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
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

            ListView {
                id: kassenzettelListe
                //model: kassenzettelmodel
                anchors.fill: parent
                interactive: true
                clip: true
                header: kassenHeading

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
                    ScrollView {
                        anchors.fill: parent
                        ScrollBar.vertical.interactive: true
                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
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
                background: Rectangle {
                    color: "#95A4A8"
                    radius: 5
                }

                delegate: ItemDelegate {
                    id:itemDlgt
                    width: name.width
                    height:40
                    padding:0

                    contentItem: Text {
                      id:textItem
                      text: modelData
                      color: hovered?"white":"#black"
                      verticalAlignment: Text.AlignVCenter
                      horizontalAlignment: Text.AlignHCenter
                      font.family: "fontawsome"
                      font.pointSize: 12
                      font.bold: true
                    }

                    background: Rectangle {
                        color:itemDlgt.hovered?"lightgrey":"white";
                        anchors.left: itemDlgt.left
                        anchors.leftMargin: 0
                        width:itemDlgt.width-2
                    }
                }
               contentItem: Text {
                     text: name.displayText
                     font: name.font
                     color: "white"
                     verticalAlignment: Text.AlignVCenter
                     horizontalAlignment: Text.AlignLeft
                     elide: Text.ElideRight
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
                        text: "Einkaufsliste kp"
                        font.family: "fontawsome"
                        font.pointSize: 24
                        color: "black"
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }
}