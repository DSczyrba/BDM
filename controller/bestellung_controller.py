from dao.nutzer_dao import NutzerDao
from model.nutzer_model import NutzerModel
from PyQt5.QtCore import *

class BestellungController(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.m_nutzermodel = NutzerModel()
        self.m_nutzerdao = NutzerDao()

    @pyqtSlot()
    def get_users(self):
        name = []
        user_data = self.m_nutzerdao.select_users()
        print(user_data)
        for i in user_data:
            name = user_data[i,'name']
        print(name)
        self.m_nutzermodel.name = name