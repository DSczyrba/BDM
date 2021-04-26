import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.qmlmodels 1.0

Pane {
    padding: 0
    background: Rectangle {
        anchors.fill: parent

        GridLayout {
            id: grid
            anchors.fill: parent
            rows: 2
            columns: 1

            Rectangle {
                
                Layout.preferredHeight: parent.height / 7               
                Layout.fillWidth: true           
                Layout.columnSpan: 1
                Layout.rowSpan: 1
                Layout.row: 0
                Layout.column: 0

                Rectangle {
                    id: header
                    color: 'lightgrey'
                    anchors.fill: parent

                    TextField {
                        id: calendarTF
                        validator: RegExpValidator { regExp:  /[0-9]{1,2}/ }
                        placeholderText: "0"
                        font.family: "fontawsome"
                        anchors.top: parent.top
                        anchors.topMargin: parent.height / 2 - (height / 2)
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 12
                        height: parent.height / 3
                    }
                    Rectangle {
                        id: calendarBtn
                        color: '#d4d4d4'
                        anchors.left: calendarTF.right
                        anchors.top: calendarTF.top
                        width: calendarTF.height
                        height: calendarTF.height

                        Image {                  
                            anchors.verticalCenter: parent.verticalCenter                    
                            anchors.horizontalCenter: parent.horizontalCenter                    
                            width: parent.width - 20
                            height: parent.height - 20
                            source: 'src/outline_edit_calendar_black_18dp.png'
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: { calendar.visible = true }
                        }

                        Calendar {
                            id: calendar
                            visible: false
                            minimumDate: new Date(2000, 0, 1)
                            maximumDate: new Date(2100, 0, 1)
                            onDoubleClicked: {
                                calendar.visible = false
                                console.log(calendar.selectedDate)
                            }
                        }   
                    }

                    ComboBox {
                        id: kategorieCB
                        anchors.left: parent.left    
                        anchors.leftMargin: parent.width / 3        
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height / 3  
                        width: parent.width / 12           
                        editable: false
                        model: ["Kategorie", "Barzahlung", "Listenzahlung", "Kassenabrechnung"]           
                    }
                }
            }

            Rectangle {
                
                Layout.fillWidth: true
                Layout.preferredHeight: parent.width - (parent.height / 7)
                Layout.columnSpan: 1
                Layout.rowSpan: 1
                Layout.row: 1
                Layout.column: 0

                ListView {
                    id: listView
                    //model: kassenzettelmodel
                    anchors.fill: parent
                    interactive: true
                    clip: true
                    model: historiemodel
                    spacing: 2
                    //header: kassenHeading
                    delegate: historieDelegate

                    Component {
                        id: historieDelegate
                        Item {
                            width: listView.width; height: 40
                            Grid {
                                anchors.fill: parent
                                columns: 2
                                spacing: 2
                                Text { id: pDatum; font.pointSize: 12; text: datum; anchors.left: parent.left; anchors.leftMargin: 10; anchors.top: parent.top; anchors.topMargin: 5}
                                Rectangle { color: 'black'; anchors.top: pDatum.bottom; anchors.topMargin: 10; anchors.left: parent.left; width: parent.width; height: 1}
                                Text { id: pKategorie; font.pointSize: 12; text: kategorie; anchors.left: parent.left; anchors.leftMargin: listView.width / 4; anchors.top: parent.top; anchors.topMargin: 5}
                                Text { id: pName; font.pointSize: 12; text: name; anchors.left: parent.left; anchors.leftMargin: listView.width / 2; anchors.top: parent.top; anchors.topMargin: 5}
                                Text { id: pBetrag; font.pointSize: 12; text: betrag + "€"; anchors.left: parent.left; anchors.leftMargin: listView.width / 1.5; anchors.top: parent.top; anchors.topMargin: 5}
                                Button { anchors.left: parent.left; anchors.top: parent.top; height: 15; text: "Löschen"; anchors.leftMargin: listView.width / 1.1; anchors.topMargin: 5
                                    onClicked: {
                                        historiecontroller.deleteContent(pDatum.text, pKategorie.text, pName.text, pBetrag.text)
                                        historiecontroller.loadTableData()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }      
    }
}