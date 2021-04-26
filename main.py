import sys
import logging
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, QQmlComponent, qmlRegisterType, QQmlEngine
from controller.bestellung_controller import BestellungController
from controller.nutzer_controller import NutzerController
from controller.artikel_controller import ArtikelController
from controller.kassen_controller import KassenController
from controller.historie_controller import HistorieController
from model.artikel_model import ArtikelModel, ArtikelModelB
from model.bestell_model import BestellModel
from model.nutzer_model import NutzerModel, NutzerKassenModel
from model.historie_model import HistorieModel
from time import gmtime, strftime

def run():
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()

    time = strftime("%d %m %Y", gmtime()).replace(" ", "") 
    logging.basicConfig(filename=f'log/{time}.log', format='%(asctime)s %(message)s', datefmt='%d/%m/%Y %H:%M:%S')
    
    #Zugriff auf die python-Klassen von qml
    nk_model = NutzerKassenModel()
    nutzermodel = NutzerModel()
    produktmodel = ArtikelModel()
    artikelmodel = ArtikelModelB()
    bestellmodel = BestellModel()
    historiemodel = HistorieModel()
    nutzercontroller = NutzerController(nutzermodel)
    bestellungcontroller = BestellungController(nutzermodel, nk_model)
    artikelcontroller = ArtikelController(produktmodel, artikelmodel)
    kassencontroller = KassenController(nk_model, nutzermodel)
    historiecontroller = HistorieController(nutzermodel, nk_model, historiemodel)
    engine.rootContext().setContextProperty('artikelcontroller', artikelcontroller)
    engine.rootContext().setContextProperty('bestellungcontroller', bestellungcontroller)
    engine.rootContext().setContextProperty('nutzercontroller', nutzercontroller)
    engine.rootContext().setContextProperty('kassencontroller', kassencontroller)
    engine.rootContext().setContextProperty('historiecontroller', historiecontroller)
    engine.rootContext().setContextProperty('produktModel', produktmodel)
    engine.rootContext().setContextProperty('artikelmodel', artikelmodel)
    engine.rootContext().setContextProperty('bestellModel', bestellmodel)
    engine.rootContext().setContextProperty('nutzerkassenmodel', nk_model)
    engine.rootContext().setContextProperty('historiemodel', historiemodel)

    engine.load('main.qml')

    return app.exec_()

if __name__ == '__main__':
    sys.exit(run())
