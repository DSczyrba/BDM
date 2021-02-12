from dao.nutzer_dao import NutzerDao
from model.nutzer_model import NutzerModel
from PyQt5.QtCore import *

class NutzerController(QObject):

    def __init__(self):
        QObject.__init__(self)
        self._nutzermodel = NutzerModel()
        self._nutzerdao = NutzerDao()
