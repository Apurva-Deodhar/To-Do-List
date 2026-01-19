import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 500
    height: 400
    title: "To Do List"
    color: "#d4e4fc"

    ListModel { id: taskModel }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        Label {
            text: "TO DO LIST"
            font.pixelSize: 18
            font.underline: true
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            color: "darkblue"
        }

         // TASK TITLE INPUT
        Rectangle {
            id: titleInput
            property alias text: titleField.text
            Layout.fillWidth: true
            height: 36
            radius: 5
            color: "lightyellow"
            border.width: 2
            border.color: titleField.activeFocus ? "#2196f3" : "green"

            TextInput {
                id: titleField
                anchors.fill: parent
                anchors.margins: 6
                font.pixelSize: 14
                color: "black"
            }

            Text {
                text: "Task Title"
                color: "#888"
                visible: titleField.text.length === 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 8
            }

            MouseArea {
                anchors.fill: parent
                onClicked: titleField.forceActiveFocus()
            }
        }

        // TASK DESCRIPTION INPUT
        Rectangle {
            id: descInput
            property alias text: descField.text
            Layout.fillWidth: true
            height: 80
            radius: 5
            color: "lightyellow"
            border.width: 2
            border.color: descField.activeFocus ? "#2196f3" : "green"

            TextEdit {
                id: descField
                anchors.fill: parent
                anchors.margins: 6
                font.pixelSize: 14
                color: "black"
                wrapMode: TextEdit.Wrap
            }

            Text {
                text: "Task Description"
                color: "#888"
                visible: descField.text.length === 0
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 8
            }

            MouseArea {
                anchors.fill: parent
                onClicked: descField.forceActiveFocus()
            }
        }

        // DATE INPUT
        Rectangle {
            id: dateInput
            property alias text: dateField.text
            Layout.fillWidth: true
            height: 36
            radius: 5
            color: "lightyellow"
            border.width: 2
            border.color: dateField.activeFocus ? "#2196f3" : "green"

            TextInput {
                id: dateField
                anchors.fill: parent
                anchors.margins: 6
                font.pixelSize: 14
                color: "black"
            }

            Text {
                text: "DD-MM-YYYY"
                color: "#888"
                visible: dateField.text.length === 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 8
            }

            MouseArea {
                anchors.fill: parent
                onClicked: dateField.forceActiveFocus()
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                id: addButton
                text: "Add Task"
                leftPadding: 10
                rightPadding: 10

                background: Rectangle {
                    color: "#6ab342"
                    border.color: "white"
                    radius: 5
                }
                onClicked: {
                    if (titleInput.text.length === 0) return
                    backend.addTask(titleInput.text, descInput.text, dateInput.text)
                    titleInput.text = ""
                    descInput.text = ""
                    dateInput.text = ""
                }
            }

            Button {
                id: "taskList"
                text: "Open Task List"
                leftPadding: 10
                rightPadding: 10

                background: Rectangle {
                    color: "#6ab342"
                    border.color: "white"
                    radius: 5
                }
                onClicked: taskListWindow.visible = true
            }
        }
    }

    TaskList {
        id: taskListWindow
        visible: false
        taskModel: taskModel
    }

    Connections {
        target: backend

        function onTaskAdded(title, desc, datetime) {
            taskModel.append({
                "title": title,
                "desc": desc,
                "datetime": datetime,
                "done": false
            })
        }
    }
}
