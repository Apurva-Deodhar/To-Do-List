//NO COLORS
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 500
    height: 550
    title: "To Do List"

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
        }

        TextField {
            id: titleInput
            placeholderText: "Task Title"
            Layout.fillWidth: true
        }

        TextArea {
            id: descInput
            placeholderText: "Task Description"
            Layout.fillWidth: true
            height: 80
        }

        TextField {
            id: dateTimeInput
            placeholderText: "DD-MM-YYYY"
            Layout.fillWidth: true
        }

        ListView {
            id: taskList
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: taskModel

            delegate: CheckDelegate {
                width: ListView.view.width
                checked: done
                text: title + "\nDescription: " + desc + "\nDate: " + datetime
                font.bold: checked

                onCheckedChanged: {
                    taskModel.set(index, {
                        "title": title,
                        "desc": desc,
                        "datetime": datetime,
                        "done": checked
                    })
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true

            Button {
                text: "Add"
                onClicked: {
                    if (titleInput.text.length === 0) 
                    return

                    backend.addTask(
                        titleInput.text,
                        descInput.text,
                        dateTimeInput.text
                    )

                    titleInput.text = ""
                    descInput.text = ""
                    dateTimeInput.text = ""
                }
            }

            Button {
                text: "Delete"
                onClicked: {
                    if (taskList.currentIndex >= 0)
                        backend.deleteTask(taskList.currentIndex)
                }
            }

            Button {
                text: "Clear All"
                onClicked: backend.clearTasks()
            }
        }
    }

    ListModel { id: taskModel }

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

        function onTaskDeleted(index) {
            taskModel.remove(index)
        }

        function onClearAll() {
            taskModel.clear()
        }
    }
}
