import sys
from PyQt5.QtCore import *
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
from model.nutzer_model import NutzerModel

def run():
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    nutzer_model = NutzerModel(engine)
    engine.rootContext().setContextProperty("nutzermodel", nutzer_model)
    engine.load('main.qml')

    return app.exec_()

if __name__ == '__main__':
    sys.exit(run())
