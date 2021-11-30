import sys
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('./UI/main.qml')
sys.exit(app.exec())

# The above code calls QGuiApplication and QQmlApplicationEngine Which will use Qml instead of QtWidgets as the UI layer for the Qt Application. It then connects the UI layers quit function with the app’s main quit function. So both can close when the UI has been closed by the user. Next it loads the qml file as the qml code for the Qml UI. The app.exec() is what runs the Application, it is inside the sys.exit because it returns the exit code of the Application which gets passed into the sys.exit which exits the python sytem.