from dao.nutzer_dao import NutzerDao
from model.nutzer_model import NutzerKassenModel
from PyQt5.QtCore import *
from dao.kassen_dao import KassenDao
import locale
import logging

class KassenController(QObject):

    kasseAktualisieren = pyqtSignal(str)

    def __init__(self, nk_model, nutzermodel):
        QObject.__init__(self)
        self._nk_model = nk_model
        self._nutzermodel = nutzermodel
        self._nutzerdao = NutzerDao()
        self._kassendao = KassenDao()

    @pyqtSlot()
    def getUsers(self):
        user_data = self._nutzerdao.select_users()  #nutzerdaten aus db holen
        if self._nk_model.rowCount() != 0:
            while self._nk_model.rowCount() != 0:
                self._nk_model.deleteNutzer(0)
        for i in range(len(user_data)):
            self._nk_model.addNutzer(user_data[i]['Name'], user_data[i]['Konto'], user_data[i]['Verein'], f"src/{user_data[i]['Bild']}")

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
        logging.warning(f'Einzahlung  von: {name} Betrag: {geld}')
        neuKasse = "{:10.2f}".format(float(kasse) + float(geld))
        konto = konto.replace('Kontostand:', '')
        neuKonto = "{:10.2f}".format(float(konto) + float(geld))
        name = name.replace(' ', '')
        self._nutzerdao.transaction(name, neuKonto)
        self._kassendao.edit_geld(neuKasse)

    @pyqtSlot()
    def getKasse(self):
        geld = self._kassendao.select_geld()
        geld = "{:,.2f}€".format(geld)
        self.kasseAktualisieren.emit(geld)
    
    @pyqtSlot(str, str, str, int)
    def abrechnen(self, verwendung, geld, name, currentIndex):
        if '€' in geld:
            geld = geld.replace('€', '')
        if ',' in geld:
            geld = geld.replace(',', '.')

        logging.warning(f'Kassenabrechnung Verwendung: {verwendung} von: {name} Betrag: {geld}')

        if name == 'Kasse':
            kasse = self._kassendao.select_geld()
            kasse = float(kasse) - float(geld)
            self._kassendao.edit_geld(kasse)
        else:
            konto = self._nutzermodel._konto[currentIndex]
            konto = float(konto) + float(geld)
            bild = self._nutzermodel._bild[currentIndex]
            mitglied = self._nutzermodel._mitglied[currentIndex]
            self._nutzerdao.edit_user(name, bild, mitglied, float(konto))
        