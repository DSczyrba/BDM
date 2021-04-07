import QtQuick 2.3
import QtQuick.Controls 2.3
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
        width: 3
        height: parent.height
    }

    Connections {
        target: artikelcontroller

        function onImPathAktualisiert(path) {
            bildInput.text = path
        }
    }

    GridLayout {
        id: nvGrid
        anchors.fill: parent
        rows: 7
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
                text: "Neues Produkt"
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
                placeholderText: "neues Produkt"
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
                text: "Preis:"
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
                id: preisInput
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
                text: "Mitglied Preis:"
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 1

            TextField {
                id: mitgliedPreisInput
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
                text: "Bild:"
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 4
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
                        artikelcontroller.copyImage(fileDialog.fileUrl)
                        neuArtikelIm.source = fileDialog.fileUrl
                    }
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 4
            Layout.column: 2

            Rectangle {
                anchors.centerIn: parent
                height: parent.height
                width: height

                Image {
                    id: neuArtikelIm
                    anchors.fill: parent
                    source: 'src/articles/baseline_sports_bar_black_18dp.png'
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
                text: "Kasten verfügbar:"
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 5
            Layout.column: 1

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
            Layout.column: 2

            Text {
                id: kstnTxt
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: parent.height/2-8
                anchors.leftMargin: 20
                font.family: "fontawsome"
                font.pointSize: 12
                font.bold: true
                color: "black"
                width: parent.width/2
                text: "Größe:"
            }

            TextField {
                    id: kastenSize
                    validator: RegExpValidator { regExp:  /[0-9]{1,2}/ }
                    placeholderText: "0"
                    font.family: "fontawsome"
                    font.pointSize: 12
                    anchors.top: parent.top
                    anchors.right: parent.right
                    width: parent.width - kstnTxt.width
                    height: parent.height / 2
                    anchors.topMargin: parent.height/2 - (height / 2)
                    anchors.rightMargin: 20
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 6
            Layout.column: 0
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 6
            Layout.column: 1

            Button {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - 20
                height: parent.height - (parent.height*0.35)
                text: "Zurücksetzen"
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 6
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
                                artikelcontroller.addArticle(nameInput.text, preisInput.text, mitgliedPreisInput.text, jaRb.checked, kastenSize.text, bildInput.text)
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
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width / 2
            Layout.columnSpan: 3
            Layout.rowSpan: 7
            Layout.row: 0
            Layout.column: 3

            Component {
                id: contactDelegate
                Item {
                    width: gridview.cellWidth; height: gridview.cellHeight
                    Grid {
                        anchors.fill: parent
                        columns: 2
                        spacing: 2
                        Image { id: pIm; source: portrait; anchors.horizontalCenter: parent.horizontalCenter; anchors.top: parent.top; anchors.topMargin: width/2}
                        Text { id: pName; font.pointSize: 12; text: 'Name'; anchors.left: parent.left; anchors.leftMargin: 40; anchors.top: pIm.bottom; anchors.topMargin: 10}
                        TextField { id: tfName; font.pointSize: 12; text: name; cursorVisible: false; anchors.right: parent.right; anchors.top: pIm.bottom; anchors.rightMargin: 10}
                        Text { id: pPreis; font.pointSize: 12; text: 'Preis'; anchors.left: parent.left; anchors.leftMargin: 40; anchors.top: pName.bottom; anchors.topMargin: 40}
                        TextField { text: preis; font.pointSize: 12; cursorVisible: false; anchors.right: parent.right; anchors.top: pName.bottom; anchors.rightMargin: 10; anchors.topMargin: 30}
                        Text { id: pMPreis; font.pointSize: 12; text: 'Mit.-Preis'; anchors.left: parent.left; anchors.leftMargin: 40; anchors.top: pPreis.bottom; anchors.topMargin: 40}
                        TextField { text: preis; font.pointSize: 12; cursorVisible: false; anchors.right: parent.right; anchors.top: pPreis.bottom; anchors.rightMargin: 10; anchors.topMargin: 30}
                        Text { id: pBestand; font.pointSize: 12; text: 'Bestand'; anchors.left: parent.left; anchors.leftMargin: 40; anchors.top: pMPreis.bottom; anchors.topMargin: 40}
                        TextField { text: preis; font.pointSize: 12; cursorVisible: false; anchors.right: parent.right; anchors.top: pMPreis.bottom; anchors.rightMargin: 10; anchors.topMargin: 30}
                    }
                }
            }

            GridView {
                id: gridview
                clip: true
                header: produktHeading
                anchors.fill: parent
                cellWidth: parent.width / 2
                cellHeight: parent.height / 2
                model: produktModel
                delegate: contactDelegate
            }
        }
    }
}