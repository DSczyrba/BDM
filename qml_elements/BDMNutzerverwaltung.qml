import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0

Pane {
    padding: 0
    background: Rectangle {
        anchors.fill: parent
    }

    Rectangle {
        color: 'black'
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: parent.width/2-1
        width: 1
        height: parent.height
    }

    Connections {
        target: bestellungcontroller

        function onNutzerDatenAktualisiert(namensliste) {
            name.model = namensliste;
        }
        function onAnzeigeDatenAktualiesieren(userdata) {
            console.log('konto ', userdata[0], 'mitglied ', userdata[1], 'bild ', userdata[2]);
            if (userdata[0] == '0.00€') {
                kontoInputBen.color = 'red';
            }
            else {
                kontoInputBen.color = 'black';
            }
            kontoInputBen.text = userdata[0];
            if (userdata[1] == 'Vereinsmitglied')
                jaRb.checked = true;
            else
                neinRb.checked = true;
            benutzerIm.source = userdata[2];
            bildInputB.text = userdata[2];
        }
        function onCbIndexAktualisieren(index) {
            name.currentIndex = index;
        }
    }

    Connections {
        target: nutzercontroller

        function onImPathAktualisiert(path, choise) {
            if (choise == 0)
                bildInput.text = path
            else
                bildInputB.text = path
        }
    }

    GridLayout {
        id: nvGrid        
        anchors.fill: parent
        rows: 5
        columns: 6

        Rectangle {                 
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 3
            Layout.rowSpan: 1
            Layout.row: 0
            Layout.column: 0

            Text {
                id: headingNeu
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: parent.height/2-14
                anchors.leftMargin: 20
                font.family: "fontawsome"
                font.pointSize: 24
                font.bold: true
                color: "black"
                width: parent.width/2
                text: "Neuer Benutzer"
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
                text: "Name:"
            }      
        }

        Rectangle {               
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 1
            Layout.column: 1

            TextField {
                id: nameInput
                placeholderText: "neuer Benutzer"
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
                text: "Konto:"
            }            
        }

        Rectangle {                
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 1

            TextField {
                id: kontoInput
                placeholderText: "0,00€"
                validator: RegExpValidator { regExp: /\d{1,3}(?:,\d{1,2})+€/ }
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
                text: "Bild:"
            }     
        }

        Rectangle {               
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 1

            TextField {
                id: bildInput
                placeholderText: "Bild auswählen"
                font.family: "fontawsome"
                font.pointSize: 12
                anchors.top: parent.top
                anchors.left: parent.left
                width: 2 * parent.width / 3
                height: parent.height / 2
                anchors.topMargin: parent.height/2 - (height / 2) 
            }

            Rectangle {
                id: bildBtn
                color: '#d4d4d4'
                anchors.left: bildInput.right
                anchors.top: bildInput.top
                height: bildInput.height
                width: height

                Image {                  
                    anchors.verticalCenter: parent.verticalCenter                    
                    anchors.horizontalCenter: parent.horizontalCenter                    
                    width: parent.width - 20
                    height: parent.height - 20
                    source: 'src/baseline_perm_media_black_18dp.png'
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: { fileDialog.visible = true }
                }

                FileDialog {
                    id: fileDialog
                    title: "Please choose an image"
                    folder: shortcuts.home
                    onAccepted: {
                        nutzercontroller.copyImage(fileDialog.fileUrl, 0)
                        neuBenutzerIm.source = fileDialog.fileUrl
                    }
                }    
            }           
        }

        Rectangle {                
            Layout.fillHeight: true       
            Layout.fillWidth: true            
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 2

            Rectangle {                
                anchors.centerIn: parent
                height: parent.height
                width: height

                Image {
                id: neuBenutzerIm
                anchors.fill: parent
                source: 'src/baseline_account_circle_black_18dp.png'
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
                text: "Mitglied:"
            }     
        }

        Rectangle {               
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 4
            Layout.column: 1 

            GroupBox {
                anchors.top: parent.top
                anchors.left: parent.left
                height: parent.height / 2
                anchors.topMargin: parent.height/2 - (height / 2)
                
                RowLayout {
                    RadioButton {
                        id: jaNeuRb
                        anchors.verticalCenter: parent.verticalCenter                                       
                        text: "Ja"
                        checked: true
                    }
                    RadioButton {
                        id: neinNeuRb
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Nein"
                    }
                }
            }    
        }

        Rectangle {          
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 0
        }

        Rectangle {                 
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 1

            Button {                
                anchors.left: parent.left             
                anchors.verticalCenter: parent.verticalCenter            
                width: parent.width - 20
                height: parent.height - (parent.height*0.35)               
                text: "Zurücksetzen"
                onClicked: {
                    nameInput.text = ''
                    kontoInput.text = ''
                    bildInput.text = ''
                    neuBenutzerIm.source = 'src/baseline_account_circle_black_18dp.png'
                }
            }
        }

        Rectangle {                 
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 2

            Button {
                anchors.centerIn: parent 
                width: parent.width - 20
                height: parent.height - (parent.height*0.35)   
                text: "Speichern"
                onClicked: {
                    if(nameInput.text == "" || bildInput.text == "")
                        popup2.open()
                    else
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

                        Text {text: "Neuen Benutzer anlegen?"}
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
                                nutzercontroller.addUser(nameInput.text, kontoInput.text, bildInput.text, jaNeuRb.checked)
                                bestellungcontroller.getUsers()
                            }
                        }
                    }
                }
            }

            Popup {
                id: popup2

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

                        Text {text: "Bitte füllen Sie alle Felder aus"}
                    }

                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.rowSpan: 1
                        Layout.row: 1
                        Layout.column: 0

                        Button {
                            anchors.fill: parent
                            text: "Ok"
                            onClicked: {
                                popup2.close()
                            }
                        }
                    }
                }
            }

        Rectangle {                 
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 3
            Layout.rowSpan: 1
            Layout.row: 0
            Layout.column: 3    

            Text {
                id: headingBearbeiten
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: parent.height/2-14
                anchors.leftMargin: 20
                font.family: "fontawsome"
                font.pointSize: 24
                font.bold: true
                color: "black"
                width: parent.width/2
                text: "Bearbeiten"
            }             
        }

        Rectangle {                
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 1
            Layout.column: 3

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
                text: "Name:"
            }       
        }

        Rectangle {                 
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 1
            Layout.column: 4

            ComboBox {
                id: name
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width - 20
                height: parent.height / 2
                anchors.topMargin: parent.height/2 - (height / 2)
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
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 3

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
                text: "Konto:"
            }           
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 4

            TextField {
                id: kontoInputBen
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
            Layout.column: 3

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
                text: "Bild:"
            }    
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 4

            TextField {
                id: bildInputB
                placeholderText: "Bild auswählen"
                font.family: "fontawsome"
                font.pointSize: 12
                anchors.top: parent.top
                anchors.left: parent.left
                width: 2 * parent.width / 3
                height: parent.height / 2
                anchors.topMargin: parent.height/2 - (height / 2)
            }

            Rectangle {
                id: bildBtnB
                color: '#d4d4d4'
                anchors.left: bildInputB.right
                anchors.top: bildInputB.top
                height: bildInputB.height
                width: height

                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 20
                    height: parent.height - 20
                    source: 'src/baseline_perm_media_black_18dp.png'
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: { fileDialogB.visible = true }
                }

                FileDialog {
                    id: fileDialogB
                    title: "Please choose an image"
                    folder: shortcuts.home
                    onAccepted: {
                        nutzercontroller.copyImage(fileDialogB.fileUrl, 1)
                        benutzerIm.source = fileDialogB.fileUrl
                    }
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 5

            Rectangle {
                anchors.centerIn: parent
                height: parent.height
                width: height

                Image {
                id: benutzerIm
                anchors.fill: parent
                source: 'src/baseline_account_circle_black_18dp.png'
                }
            }
        }

        Rectangle {                
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 4
            Layout.column: 3

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
                text: "Mitglied:"
            }    
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 4
            Layout.column: 4

            GroupBox {
                anchors.top: parent.top
                anchors.left: parent.left
                height: parent.height / 2
                anchors.topMargin: parent.height/2 - (height / 2)

                RowLayout {
                    RadioButton {
                        id: jaRb
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Ja"
                        checked: true
                    }
                    RadioButton {
                        id: neinRb
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Nein"
                    }
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 3
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 4

            Button {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - 20
                height: parent.height - (parent.height*0.35)
                text: "Löschen"
                onClicked: {
                    popup3.open()
                }
            }
            Popup {
                id: popup3

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

                        Text {text: "Wollen Sie diesen Benutzer wirklich löschen?"}
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
                                popup3.close()
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
                                popup3.close()
                                nutzercontroller.deleteUser(name.currentIndex)
                                bestellungcontroller.getUsers()
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 5

            Button {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - 20
                height: parent.height - (parent.height*0.35)
                text: "Bearbeiten"
                onClicked: {
                    popup4.open()
                }
            }
            Popup {
                id: popup4

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

                        Text {text: "Wollen Sie diesen Benutzer wirklich bearbeiten?"}
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
                                popup4.close()
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
                                popup4.close()
                                nutzercontroller.updateUser(name.currentIndex, kontoInputBen.text, bildInputB.text, jaRb.checked)
                                bestellungcontroller.getUsers()
                            }
                        }
                    }
                }
            }
        }


/*
        Rectangle {          
            color: "red"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 0
            Layout.column: 1   

            Image {
                id: profilbild
                anchors.fill: parent
            }        
        }

        Rectangle {          
            color: "red"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
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
            color: "blue"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 1

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
            color: "green"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 1

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
        }  */      
    }
}