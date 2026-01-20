import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: listWindow
    width: 700
    height: 420
    title: "Task List"
    visible: false
    color: "#d4e4fc"

    property var taskModel
    property bool editMode: false

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // WINDOW TITLE
        Label {
            text: "ALL TASKS"
            font.pixelSize: 18
            font.underline: true
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            color: "darkblue"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            // TASK LIST WINDOW
            Rectangle {
                Layout.preferredWidth: 300
                Layout.fillHeight: true
                radius: 5
                border.width: 2
                border.color: "green"
                color: "lightyellow"

                //SCROLL IN LIST VIEW
                ScrollView {  
                    anchors.fill: parent
                    clip: true

                    //TASK LIST VIEW
                    ListView { 
                        id: listView
                        model: taskModel
                        currentIndex: -1

                        delegate: Item {
                            width: ListView.view.width
                            height: 70

                            //BACKGROUND OF EACH TASK  
                            Rectangle {  
                                anchors.fill: parent
                                anchors.margins: 5
                                radius: 5
                                border.width: 2
                                border.color: listView.currentIndex === index ? "#2196f3" : "#999"
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

                                    //EDIT BUTTON
                                    Button { 
                                        id: "editButton"
                                        text: "Edit"
                                        contentItem: Text {
                                            text: parent.text
                                            color: "white"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        background: Rectangle {
                                            color: "#6ab342"
                                            radius: 5
                                        }
                                        onClicked: {
                                            listView.currentIndex = index
                                            editMode = true
                                        }
                                    }

                                } //ROW LAYOUT END

                            } //RECTANGLE BG END

                        } //DELEGATE ITEM END

                    } //LIST VIEW END

                } //SCROLLVIEW END

            } //TASK LIST RECTANGLE END


            // EDIT WINDOW IN SAME WINDOW

            // EDIT WINDOW BACKGROUND 
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 5
                border.width: 1
                color: "white"
                visible: editMode && listView.currentIndex >= 0

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    //EDIT WINDOW HEADING
                    Label {
                        text: "Edit Task"
                        font.pixelSize: 15
                        font.bold: true
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }

                    // TASK TITLE INPUT
                    Rectangle {
                        id: titleInput
                        property alias text: editTitle.text
                        Layout.fillWidth: true
                        height: 36
                        radius: 5
                        color: "lightyellow"
                        border.width: 2
                        border.color: editTitle.activeFocus ? "#2196f3" : "green"

                        TextInput {
                            id: editTitle
                            anchors.fill: parent
                            anchors.margins: 6
                            font.pixelSize: 14
                            color: "black"
                        }

                        Text {
                            text: "Task Title"
                            color: "#888"
                            visible: editTitle.text.length === 0
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: editTitle.forceActiveFocus()
                        }
                    }

                    // TASK DESCRIPTION INPUT
                    Rectangle {
                        id: descInput
                        property alias text: editDesc.text
                        Layout.fillWidth: true
                        height: 80
                        radius: 5
                        color: "lightyellow"
                        border.width: 2
                        border.color: editDesc.activeFocus ? "#2196f3" : "green"

                        TextEdit {
                            id: editDesc
                            anchors.fill: parent
                            anchors.margins: 6
                            font.pixelSize: 14
                            color: "black"
                            wrapMode: TextEdit.Wrap
                        }

                        Text {
                            text: "Task Description"
                            color: "#888"
                            visible: editDesc.text.length === 0
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.margins: 8
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: editDesc.forceActiveFocus()
                        }
                    }

                    // TASK DATE INPUT
                    Rectangle {
                        id: dateInput
                        property alias text: editDate.text
                        Layout.fillWidth: true
                        height: 36
                        radius: 5
                        color: "lightyellow"
                        border.width: 2
                        border.color: editDate.activeFocus ? "#2196f3" : "green"

                        TextInput {
                            id: editDate
                            anchors.fill: parent
                            anchors.margins: 6
                            font.pixelSize: 14
                            color: "black"
                        }

                        Text {
                            text: "DD-MM-YYYY"
                            color: "#888"
                            visible: editDate.text.length === 0
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: editDate.forceActiveFocus()
                        }
                    }

                    // BUTTONS ROW
                    RowLayout {
                        spacing: 10

                        // SAVE BUTTON
                        Button {
                            text: "Save"
                            background: Rectangle { color: "#6ab342"; radius: 5 }
                            onClicked: {
                                taskModel.set(listView.currentIndex, {
                                    title: editTitle.text,
                                    desc: editDesc.text,
                                    datetime: editDate.text,
                                    done: taskModel.get(listView.currentIndex).done
                                })
                                editMode = false
                            }
                        }

                        // CANCEL BUTTON
                        Button {
                            text: "Cancel"
                            background: Rectangle {
                            color: '#e2f253'
                            radius: 5
                            }
                            onClicked: editMode = false
                        }

                        // DELETE BUTTON
                        Button {
                            text: "Delete"
                            background: Rectangle { color: "#bb5c44"; radius: 5 }
                            onClicked: deletePopup.open()
                        }

                    }  // RowLayout END

                } // ColumnLayout END

            } //EDIT WINDOW RECTANGLE END

        } // OUTERMOST ROWLAYOUT END

    } // OUTERMOST COLUMNLAYOUT END 


    // LOAD DATA WHEN CLICKED EDIT
    Connections {
        target: listView
        function onCurrentIndexChanged() {
            if (!editMode || listView.currentIndex < 0) return
            let item = taskModel.get(listView.currentIndex)
            editTitle.text = item.title
            editDesc.text = item.desc
            editDate.text = item.datetime
        }
    }

    // DELETE POPUP
    Popup {
        id: deletePopup
        modal: true
        focus: true
        anchors.centerIn: parent
        width: 260
        height: 120

        // POPUP BACKGROUND
        background: Rectangle {
            color: "white"
            border.color: "black"
            border.width: 2
            radius: 5
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            //TEXT LABEL
            Label {
                text: "Delete this task?"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                color: "Black"
                font.pixelSize: 18
                font.italic: true
            }

            RowLayout {
                spacing: 10

                //CANCEL BUTTON
                Button {
                    text: "Cancel"
                    leftPadding: 10
                    rightPadding: 10
                    background: Rectangle {
                    color: '#e2f253'
                    radius: 5
                    }
                    onClicked: deletePopup.close()
                }

                // DELETE BUTTON
                Button {
                    text: "Delete"
                    leftPadding: 10
                    rightPadding: 10
                    background: Rectangle {
                    color: "#c96242"
                    radius: 5
                }
                    onClicked: {
                        taskModel.remove(listView.currentIndex)
                        listView.currentIndex = -1
                        editMode = false
                        deletePopup.close()
                    }
                }

            } // POPUP ROWLAYOUT END

        } // POPUP ColumnLayout END 

    } //POPUP END

} //WINDOW END

