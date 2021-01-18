import sys
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, QQmlComponent, qmlRegisterType, QQmlEngine
from controller.bestellung_controller import BestellungController
from model.nutzer_model import NutzerModel


def run():
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()

    #Zugriff auf die python-Klassen von qml
    bestellungcontroller = BestellungController()
    engine.rootContext().setContextProperty("bestellungcontroller", bestellungcontroller)

    engine.load('main.qml')

    return app.exec_()

if __name__ == '__main__':
    sys.exit(run())
