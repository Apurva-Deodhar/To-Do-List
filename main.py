import sys
from PyQt6.QtCore import QObject, pyqtSignal, pyqtSlot
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine

class TodoBackend(QObject):
    taskAdded = pyqtSignal(str, str, str)
    taskDeleted = pyqtSignal(int)
    clearAll = pyqtSignal()

    @pyqtSlot(str, str, str)
    def addTask(self, title, desc, datetime):
        self.taskAdded.emit(title, desc, datetime)

    @pyqtSlot(int)
    def deleteTask(self, index):
        self.taskDeleted.emit(index)

    @pyqtSlot()
    def clearTasks(self):
        self.clearAll.emit()

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()
    backend = TodoBackend()
    engine.rootContext().setContextProperty("backend", backend)

    #connect to main.qml
    engine.load("main.qml")
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
