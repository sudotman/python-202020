import sys
from time import localtime, strftime, gmtime # For retreiving string based time
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal
import threading
from time import sleep
import time
from win10toast import ToastNotifier

# Creating QObject subclass to be able to utilize python threads to send signals to our qt frontend
class Backend(QObject):
    def __init__(self):
        QObject.__init__(self)

    updated = pyqtSignal(str, arguments=['updater'])
    secondUpdated = pyqtSignal(str,arguments=['countdownUpdater']) # Break countdown
    breakTextUpdated = pyqtSignal(str,arguments=['breakTextUpdater']) # Break text
    promptTextUpdated = pyqtSignal(str,arguments=['breakPromptUpdater']) # Break prompt
    
    def updater(self, curr_time):
        self.updated.emit(curr_time)

    def countdownUpdater(self, count):
        self.secondUpdated.emit(count) # break countdown

    def breakTextUpdater(self, text):
        self.breakTextUpdated.emit(text) # break text

    def breakPromptUpdater(self, promptText):
        self.promptTextUpdated.emit(promptText) # break prompt
        
      
    def bootUp(self):
        

        t_thread = threading.Thread(target=self._bootUp)
        t_thread.daemon = True
        t_thread.start()

    def _bootUp(self):
        while True:
            curr_time = strftime("%H:%M:%S", localtime())
            self.updater(curr_time)
            
            sleep(0.1)

    def do2020(self):
        t1_thread = threading.Thread(target=self._do2020)
        t1_thread.daemon = True
        t1_thread.start()

    def _do2020(self):
        toast = ToastNotifier()
        eyePath = "./Images/eye.jpg"
        normalPath = "./Images/image1.jpg"

        timeInitial = time.time()

        while True:
            engine.rootObjects()[0].setProperty('imagePath', eyePath)
            toast.show_toast("Hey there!","Look away at something 20 metres away for 20 seconds. Thanks! And good luck with your work :)",icon_path='./icon.ico',duration=20, threaded=True)

            print("Displayed toast")
            while toast.notification_active(): 
                time.sleep(0.1)
                engine.rootObjects()[0].setProperty('imagePath', eyePath)
                self.breakTextUpdater("transparent")
                self.breakPromptUpdater("white")

            print("Toast finished")
            self.breakPromptUpdater("transparent")
            engine.rootObjects()[0].setProperty('imagePath', normalPath)
            # self.countDown() #Experimental countdown stuff
            sleep(24)
    
    def countDown(self):
        for i in range(29,0,-1):
            if i <=25:
                self.countdownUpdater(str(i)) # break countdown
                self.breakTextUpdater("white") # update break text to white
            else:
                self.breakTextUpdater("transparent") # update break text to transparent
            time.sleep(1)
            print(i)
            


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
back_end.do2020()
#engine.rootObjects()[0].setProperty('currTime', curr_time) # Sending our current time variable over to our UI

sys.exit(app.exec())

# The above code calls QGuiApplication and QQmlApplicationEngine Which will use Qml instead of QtWidgets as the UI layer for the Qt Application. It then connects the UI layers quit function with the app’s main quit function. So both can close when the UI has been closed by the user. Next it loads the qml file as the qml code for the Qml UI. The app.exec() is what runs the Application, it is inside the sys.exit because it returns the exit code of the Application which gets passed into the sys.exit which exits the python sytem.