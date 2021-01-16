import sys
from PyQt5.QtCore import *
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine, QQmlComponent
from model.nutzer_model import NutzerModel

def run():
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    component = QQmlComponent(engine)
    nutzer_model = NutzerModel(engine)
    engine.rootContext().setContextProperty("nutzermodel", NutzerModel)
    component.loadUrl(QUrl('main.qml'))
    name = component.create()
    engine.load('main.qml')

    return app.exec_()

if __name__ == '__main__':
    sys.exit(run())
