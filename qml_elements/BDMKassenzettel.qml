import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Pane {
    padding: 0
    background: Rectangle {
        anchors.fill: parent
    }

    Rectangle {
            color: 'black'
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: parent.height/2 + 1
            height: 1
            width: parent.width
    }
    Rectangle {
            color: 'black'
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2+1
            width: 1
            height: parent.height/2 - 1
        }

    Connections {
        target: bestellungcontroller

        function onNutzerDatenAktualisiert(namensliste) {
            namensliste.push('Kasse')
            nameCB.model = namensliste;
        }
    }

    Connections {
        target: kassencontroller

        function onKasseAktualisieren(kasseGeld) {
            console.log('Kasse: ' + kasseGeld)
            kasse.text = kasseGeld
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
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 0
            Layout.column: 0

            Text {                
                anchors.centerIn: parent               
                font.family: "fontawsome"
                font.pointSize: 24
                font.bold: true
                color: "black"
                text: "Kassenzettel"
            }
        }

        Rectangle {
            
            Layout.fillHeight: true            
            Layout.fillWidth: true           
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 1
            Layout.column: 0

            Text {                
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: parent.height/2-8
                anchors.leftMargin: 20
                font.family: "fontawsome"
                font.pointSize: 12
                font.bold: true
                color: "black"
                width: parent.width/2
                text: "Verwendung:"
            }
        }

        Rectangle {
            
            Layout.fillHeight: true            
            Layout.fillWidth: true           
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 1
            Layout.column: 1

            TextField {
                id: verwendung
                font.family: "fontawsome"
                font.pointSize: 12
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width - 20
                height: parent.height / 2
                anchors.topMargin: parent.height/2 - (height / 2)
            }
        }

        Rectangle {
            
            Layout.fillHeight: true            
            Layout.fillWidth: true           
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 0

            Text {                
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: parent.height/2-8
                anchors.leftMargin: 20
                font.family: "fontawsome"
                font.pointSize: 12
                font.bold: true
                color: "black"
                width: parent.width/2
                text: "Kosten:"
            }
        }

        Rectangle {
            
            Layout.fillHeight: true            
            Layout.fillWidth: true           
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 1

            TextField {
                id: kostenInput
                validator: RegExpValidator { regExp: /\d{1,3}(?:,\d{1,2})+€/ }
                placeholderText: "0,00€"
                font.family: "fontawsome"
                font.pointSize: 12
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width - 20
                height: parent.height / 2
                anchors.topMargin: parent.height/2 - (height / 2)
            }
        }

        Rectangle {
            
            Layout.fillHeight: true            
            Layout.fillWidth: true           
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 0

            Text {                
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: parent.height/2-8
                anchors.leftMargin: 20
                font.family: "fontawsome"
                font.pointSize: 12
                font.bold: true
                color: "black"
                width: parent.width/2
                text: "Wer hat's bezahlt?:"
            }
        }

        Rectangle {
            
            Layout.fillHeight: true            
            Layout.fillWidth: true           
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 1

            ComboBox {
                id: nameCB
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: parent.height/2 - height/2
                width: parent.width - 20
                height: parent.height / 2
                editable: false
                model: nutzerliste

                onCurrentIndexChanged: {
                    bestellungcontroller.getCurrentCBData(currentIndex)
                }
                Component.onCompleted: {
                    bestellungcontroller.getUsers()
                    kassencontroller.getUsers()
                }            
            }
        }

        Rectangle {
            Layout.fillHeight: true                       
            Layout.fillWidth: true                 
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 4
            Layout.column: 0

            Button {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 20
                width: parent.width - 30
                height: parent.height - (parent.height*0.35)
                text: "Zurücksetzen"

                onClicked: {
                    kostenInput.text = ''
                    verwendung.text = ''
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true                  
            Layout.fillWidth: true              
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 4
            Layout.column: 1

            Button {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - 20
                height: parent.height - (parent.height*0.35)
                text: "Speichern"

                onClicked: {
                    popup1.open()
                }
            }
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

                    Text {text: "Soll das so abgerechnet werden?"}
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
                            console.log(verwendung.text, kostenInput.text, nameCB.currentIndex)
                            kassencontroller.abrechnen(verwendung.text, kostenInput.text, nameCB.currentText, nameCB.currentIndex)
                            kassencontroller.getKasse()
                            kassencontroller.getUsers()
                            kostenInput.text = ''
                            verwendung.text = ''
                        }
                    }
                }
            }
        }

        Rectangle {
            
            Layout.fillHeight: true            
            Layout.preferredWidth: parent.width/2           
            Layout.columnSpan: 1
            Layout.rowSpan: 5
            Layout.row: 0
            Layout.column: 3

            Text {    
                id: txtKasse            
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: parent.height/2-8
                anchors.leftMargin: 20
                font.family: "fontawsome"
                font.pointSize: 12
                font.bold: true
                color: "black"
                width: parent.width/2
                text: "Kasse:"
            }
            Text {        
                id: kasse        
                anchors.bottom: parent.bottom
                anchors.left: txtKasse.right
                anchors.bottomMargin: parent.height/2-8
                anchors.leftMargin: 20
                font.family: "fontawsome"
                font.pointSize: 12
                font.bold: true
                color: "black"
                width: parent.width/2
                text: "0,00€"
            }            
        }

        Rectangle {
            
            Layout.preferredHeight: parent.height/2
            Layout.fillWidth: true           
            Layout.columnSpan: 3
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 0

            Component {
                id: contactDelegate
                Item {
                    id: item
                    width: gridview.cellWidth; height: gridview.cellHeight
                    Grid {
                        anchors.fill: parent
                        columns: 2
                        spacing: 2
                        Image { id: pIm; source: portrait; anchors.horizontalCenter: parent.horizontalCenter; anchors.top: parent.top; anchors.topMargin: width/2 + height/2; width: 60; height: 60}
                        Text { id: pName; font.pointSize: 12; text: name; anchors.horizontalCenter: parent.horizontalCenter; anchors.top: pIm.bottom; anchors.topMargin: 5}
                        Text { id: pPreis; font.pointSize: 12; text: 'Kontostand: ' + konto; anchors.horizontalCenter: parent.horizontalCenter; anchors.top: pName.bottom; anchors.topMargin: 5}
                        Button { 
                            id: einzahlen; 
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: pPreis.bottom                          
                            anchors.topMargin: 5                    
                            text: 'Einzahlen'

                            onClicked: {
                                popup.open()
                            }
                        }
                        Popup {
                            id: popup

                            parent: Overlay.overlay

                            x: Math.round((parent.width - width) / 2)
                            y: Math.round((parent.height - height) / 2)
                            width: 500
                            height: 150

                            GridLayout {
                                anchors.fill: parent
                                rows: 3
                                columns: 2

                                Rectangle {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.columnSpan: 2
                                    Layout.rowSpan: 1
                                    Layout.row: 0
                                    Layout.column: 0

                                    Text {text: "Wieviel soll eingezahlt werden?"}
                                }

                                Rectangle {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.columnSpan: 1
                                    Layout.rowSpan: 1
                                    Layout.row: 1
                                    Layout.column: 0

                                    TextField {
                                        id: einzahlung
                                        validator: RegExpValidator { regExp: /\d{1,3}(?:,\d{1,2})/ }
                                        placeholderText: "0"
                                        font.family: "fontawsome"
                                        font.pointSize: 12
                                        anchors.top: parent.top
                                        anchors.right: parent.right
                                    }
                                }

                                Rectangle {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.columnSpan: 1
                                    Layout.rowSpan: 1
                                    Layout.row: 2
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
                                    Layout.row: 2
                                    Layout.column: 1

                                    Button {
                                        anchors.fill: parent
                                        text: "Ok"
                                        onClicked: {
                                            popup.close()
                                            kassencontroller.einzahlen(pName.text, einzahlung.text, pPreis.text, kasse.text)
                                            bestellungcontroller.getUsers()
                                            kassencontroller.getUsers()
                                            kassencontroller.getKasse()
                                        }
                                    }
                                }
                            }
                        }      
                    }
                }
            }

            GridView {
                id: gridview
                clip: true
                header: produktHeading
                anchors.fill: parent
                cellWidth: parent.width / 5
                cellHeight: parent.height / 2
                model: nutzerkassenmodel
                delegate: contactDelegate
            }
        }
    }
}