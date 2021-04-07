import sys
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, QQmlComponent, qmlRegisterType, QQmlEngine
from controller.bestellung_controller import BestellungController
from controller.nutzer_controller import NutzerController
from controller.artikel_controller import ArtikelController
from model.artikel_model import ArtikelModel
from model.bestell_model import BestellModel
from model.nutzer_model import NutzerModel

def run():
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()

    #Zugriff auf die python-Klassen von qml
    nutzermodel = NutzerModel()
    produktmodel = ArtikelModel()
    bestellmodel = BestellModel()
    nutzercontroller = NutzerController(nutzermodel)
    bestellungcontroller = BestellungController(nutzermodel)
    artikelcontroller = ArtikelController(produktmodel)
    engine.rootContext().setContextProperty('artikelcontroller', artikelcontroller)
    engine.rootContext().setContextProperty('bestellungcontroller', bestellungcontroller)
    engine.rootContext().setContextProperty('nutzercontroller', nutzercontroller)
    engine.rootContext().setContextProperty('produktModel', produktmodel)
    engine.rootContext().setContextProperty('bestellModel', bestellmodel)

    engine.load('main.qml')

    return app.exec_()

if __name__ == '__main__':
    sys.exit(run())
