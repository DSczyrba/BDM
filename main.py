import sys
from PyQt5.QtCore import QUrl
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine


def run():
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load('main.qml')

    if not engine.rootObjects():
        return -1

    return app.exec_()
#penis

if __name__ == '__main__':
    sys.exit(run())
