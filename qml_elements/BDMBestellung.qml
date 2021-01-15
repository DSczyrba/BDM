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

    GridLayout {
        id: grid
        anchors.fill: parent
        rows: 8
        columns: 3

        Rectangle {
            color: "red"
            Layout.fillHeight: true
            Layout.minimumWidth: parent.width/1.8
            Layout.columnSpan: 1
            Layout.rowSpan: 8
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
            Layout.rowSpan: 2
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
            Layout.row: 2
            Layout.column: 1

            ComboBox {
                id: name
                anchors.fill: parent
                editable: false
                model: ListModel {
                    id: model
                    ListElement { text: "Banana" }
                    ListElement { text: "Apple" }
                    ListElement { text: "Coconut" }
                }
            }
        }

        Rectangle {
            color: "yellow"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 3
            Layout.row: 3
            Layout.column: 1
        }

        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 2

            Label {
                text: name.currentText
                font.pixelSize: 22
                font.italic: true
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

        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.rowSpan: 1
            Layout.row: 6
            Layout.column: 1
        }

        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 7
            Layout.column: 1
        }

        Rectangle {
            color: "white"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 7
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