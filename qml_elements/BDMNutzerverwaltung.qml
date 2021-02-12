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
        anchors.leftMargin: parent.width/2-1
        width: 3
        height: parent.height
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
        function onCbIndexAktualisieren(index) {
            name.currentIndex = index;
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
            color: "blue"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 1
            Layout.column: 1     
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
            color: "green"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 1         
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
            color: "red"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 1     
        }

        Rectangle {          
            color: "red"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 2  
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
            color: "yellow"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 4
            Layout.column: 1     
        }

        Rectangle {          
            color: "yellow"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 4
            Layout.column: 2  
        }

        Rectangle {          
            color: "brown"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 3
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 0
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
            color: "green"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 4        
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
            color: "red"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 4    
        }

        Rectangle {          
            color: "red"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 5  
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
            color: "yellow"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 4
            Layout.column: 4    
        }

        Rectangle {          
            color: "yellow"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 4
            Layout.column: 5  
        }

        Rectangle {          
            color: "brown"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 3
        }

        Rectangle {          
            color: "brown"        
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 5
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