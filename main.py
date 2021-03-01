import sys
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, QQmlComponent, qmlRegisterType, QQmlEngine
from controller.bestellung_controller import BestellungController
from model.artikel_model import ArtikelModel
from model.bestell_model import BestellModel

def run():
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()

    #Zugriff auf die python-Klassen von qml
    bestellungcontroller = BestellungController()
    produktmodel = ArtikelModel()
    bestellmodel = BestellModel()
    engine.rootContext().setContextProperty('bestellungcontroller', bestellungcontroller)
    engine.rootContext().setContextProperty('produktModel', produktmodel)
    engine.rootContext().setContextProperty('bestellModel', bestellmodel)

    engine.load('main.qml')

    return app.exec_()

if __name__ == '__main__':
    sys.exit(run())
