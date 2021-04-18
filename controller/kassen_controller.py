from dao.nutzer_dao import NutzerDao
from model.nutzer_model import NutzerKassenModel
from PyQt5.QtCore import *
from dao.kassen_dao import KassenDao
import locale

class KassenController(QObject):

    kasseAktualisieren = pyqtSignal(str)

    def __init__(self, nk_model):
        QObject.__init__(self)
        self._nutzermodel = nk_model
        self._nutzerdao = NutzerDao()
        self._kassendao = KassenDao()

    @pyqtSlot()
    def getUsers(self):
        user_data = self._nutzerdao.select_users()  #nutzerdaten aus db holen
        if self._nutzermodel.rowCount() != 0:
            while self._nutzermodel.rowCount() != 0:
                self._nutzermodel.deleteNutzer(0)
        for i in range(len(user_data)):
            self._nutzermodel.addNutzer(user_data[i]['Name'], user_data[i]['Konto'], user_data[i]['Verein'], f"src/{user_data[i]['Bild']}")

    @pyqtSlot(str, str, str, str)
    def einzahlen(self, name, geld, konto, kasse):
        if '€' in geld:
            geld = geld.replace('€', '')
        if ',' in geld:
            geld = geld.replace(',', '.')
        if '€' in kasse:
            kasse = kasse.replace('€', '')
        if ',' in kasse:
            kasse = kasse.replace(',', '.')
        neuKasse = float(kasse) + float(geld)
        konto = konto.replace('Kontostand:', '')
        neuKonto = float(konto) + float(geld)
        name = name.replace(' ', '')
        self._nutzerdao.transaction(name, neuKonto)
        self._kassendao.edit_geld(neuKasse)

    @pyqtSlot()
    def getKasse(self):
        geld = self._kassendao.select_geld()
        geld = "{:,.2f}€".format(geld)
        self.kasseAktualisieren.emit(geld)
        