import sys
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, QQmlComponent, qmlRegisterType, QQmlEngine
from controller.bestellung_controller import BestellungController
from controller.nutzer_controller import NutzerController
from controller.artikel_controller import ArtikelController
from controller.kassen_controller import KassenController
from model.artikel_model import ArtikelModel
from model.bestell_model import BestellModel
from model.nutzer_model import NutzerModel, NutzerKassenModel

def run():
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()

    #Zugriff auf die python-Klassen von qml
    nk_model = NutzerKassenModel()
    nutzermodel = NutzerModel()
    produktmodel = ArtikelModel()
    bestellmodel = BestellModel()
    nutzercontroller = NutzerController(nutzermodel)
    bestellungcontroller = BestellungController(nutzermodel, nk_model)
    artikelcontroller = ArtikelController(produktmodel)
    kassencontroller = KassenController(nk_model)
    engine.rootContext().setContextProperty('artikelcontroller', artikelcontroller)
    engine.rootContext().setContextProperty('bestellungcontroller', bestellungcontroller)
    engine.rootContext().setContextProperty('nutzercontroller', nutzercontroller)
    engine.rootContext().setContextProperty('kassencontroller', kassencontroller)
    engine.rootContext().setContextProperty('produktModel', produktmodel)
    engine.rootContext().setContextProperty('bestellModel', bestellmodel)
    engine.rootContext().setContextProperty('nutzerkassenmodel', nk_model)

    engine.load('main.qml')

    return app.exec_()

if __name__ == '__main__':
    sys.exit(run())
