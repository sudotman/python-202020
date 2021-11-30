import sys
from time import localtime, strftime, gmtime # For retreiving string based time
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal
import threading
from time import sleep

# Creating QObject subclass to be able to utilize python threads to send signals to our qt frontend
class Backend(QObject):
    def __init__(self):
        QObject.__init__(self)

    updated = pyqtSignal(str, arguments=['updater'])
    
    def updater(self, curr_time):
        self.updated.emit(curr_time)
      
    def bootUp(self):
        t_thread = threading.Thread(target=self._bootUp)
        t_thread.daemon = True
        t_thread.start()

    def _bootUp(self):
        while True:
            curr_time = strftime("%H:%M:%S", localtime())
            self.updater(curr_time)
            sleep(0.1)

#Time stuff
curr_time = strftime("%H:%M:%S", localtime())


#UI hook stuff
app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('./UI/main.qml')
back_end = Backend()
engine.rootObjects()[0].setProperty('backend', back_end)
back_end.bootUp()
#engine.rootObjects()[0].setProperty('currTime', curr_time) # Sending our current time variable over to our UI

sys.exit(app.exec())

# The above code calls QGuiApplication and QQmlApplicationEngine Which will use Qml instead of QtWidgets as the UI layer for the Qt Application. It then connects the UI layers quit function with the app’s main quit function. So both can close when the UI has been closed by the user. Next it loads the qml file as the qml code for the Qml UI. The app.exec() is what runs the Application, it is inside the sys.exit because it returns the exit code of the Application which gets passed into the sys.exit which exits the python sytem.