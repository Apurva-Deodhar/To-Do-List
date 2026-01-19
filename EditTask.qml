import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: editWindow
    width: 400
    height: 300
    title: "Edit Task"
    color: "#d4e4fc"
    visible: false

    property var taskModel
    property int editIndex: -1

    function open(index) {
        editIndex = index
        titleInput.text = taskModel.get(index).title
        descInput.text = taskModel.get(index).desc
        dateInput.text = taskModel.get(index).datetime
        visible = true
    }

    ColumnLayout {
        Label {
            text: "Edit Task"
            font.pixelSize: 15
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            color: "darkblue"
        }
        anchors.fill: parent
        anchors.margins: 20

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
        Button {
            id: "saveButton"
            text: "Save"
            leftPadding: 10
            rightPadding: 10
            anchors.topMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom                
            background: Rectangle {
                color: "#6ab342"
                border.color: "white"
                radius: 5
                }
            onClicked: {
                taskModel.set(editIndex, {
                    title: titleInput.text,
                    desc: descInput.text,
                    datetime: dateInput.text,
                    done: taskModel.get(editIndex).done
                })
                
                editWindow.visible = false
            }
        }
    }
}
