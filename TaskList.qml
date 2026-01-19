import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: listWindow
    width: 550
    height: 400
    title: "Task List"
    color: "#d4e4fc"
    visible: false

    property var taskModel

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Label {
            text: "ALL TASKS"
            font.pixelSize: 18
            font.underline: true
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            color: "darkblue"
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                id: listView
                model: taskModel
                currentIndex: -1
                boundsBehavior: Flickable.StopAtBounds

                delegate: Item {
                    width: ListView.view.width
                    height: 70  

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 5  
                        radius: 5
                        border.width: 2
                        border.color: listView.currentIndex === index
                                      ? "#2196f3"
                                      : "#999"
                        color: "white"

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 10

                            CheckBox {
                                checked: done
                                onCheckedChanged: {
                                    taskModel.set(index, {
                                        title: title,
                                        desc: desc,
                                        datetime: datetime,
                                        done: checked
                                    })
                                }
                            }

                            Text {
                                text: title + " (" + datetime + ")"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: listView.currentIndex = index
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 15
            Button {
                text: "Edit"
                enabled: listView.currentIndex >= 0

                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    color: "#6ab342"
                    radius: 5
                }

                onClicked: editWindow.open(listView.currentIndex)
            }

    
            Button {
                text: "Delete"
                enabled: listView.currentIndex >= 0

                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    color: "#bb5c44"
                    radius: 5
                }

                onClicked: taskModel.remove(listView.currentIndex)
            }
        }

        EditTask {
            id: editWindow
            taskModel: listWindow.taskModel
        }
    }
}
