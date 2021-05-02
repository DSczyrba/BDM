import shutil
import logging
from datetime import datetime
from dao.nutzer_dao import NutzerDao
from dao.kassen_dao import KassenDao
from dao.historie_dao import HistorieDao
from dao.artikel_dao import ArtikelDao
from model.nutzer_model import NutzerModel, NutzerKassenModel
from model.artikel_model import ArtikelModel
from PyQt5.QtCore import *

class BestellungController(QObject):

    nutzerDatenAktualisiert = pyqtSignal(list)
    anzeigeDatenAktualiesieren = pyqtSignal(list)
    cbIndexAktualisieren = pyqtSignal(int)
    productmodelAktualisiert = pyqtSignal(QAbstractListModel)
    updateImage = pyqtSignal(str)

    def __init__(self, nutzermodel, nk_model):
        QObject.__init__(self)
        self._nutzerkassenmodel = nk_model
        self._nutzermodel = nutzermodel
        self._nutzerdao = NutzerDao()
        self._artikelmodel = ArtikelModel()
        self._kassendao = KassenDao()
        self._historiedao = HistorieDao()
        self._artikeldao = ArtikelDao()

    @pyqtSlot()
    def getUsers(self):
        names = []
        konten = []
        mitglied = []
        bild = []
        user_data = self._nutzerdao.select_users()  #nutzerdaten aus db holen
        for i in range(len(user_data)):
            names.append(user_data[i]['Name'])
            konten.append(user_data[i]['Konto'])
            mitglied.append(user_data[i]['Verein'])
            bild.append(user_data[i]['Bild'])
        self._nutzermodel._names = names    #list für combobox setzen
        self._nutzermodel._konto = konten
        self._nutzermodel._mitglied = mitglied
        self._nutzermodel._bild = bild
        self.nutzerDatenAktualisiert.emit(self._nutzermodel._names) #funktion onNutzerDatenAktualisiert aufrufen

    @pyqtSlot(int)
    def getCurrentCBData(self, currentIndex):
        try:
            konto = self._nutzermodel._konto[currentIndex]
            mitglied = self._nutzermodel._mitglied[currentIndex]
            bild = f'src/{self._nutzermodel._bild[currentIndex]}'
            konto = "{:.2f}€".format(konto)

            if mitglied == 0:
                mitglied = 'Besucher'
            else:
                mitglied = 'Vereinsmitglied'

            self.anzeigeDatenAktualiesieren.emit([str(konto), str(mitglied), str(bild)])
        except:
            pass

    @pyqtSlot(int)
    def updateCBIndex(self, index):
        self.cbIndexAktualisieren.emit(index)

    @pyqtSlot(int, float, str)
    def pay(self, index, konto, geld):
        self._nutzerdao.edit_user(self._nutzermodel._names[index], self._nutzermodel._bild[index], self._nutzermodel._mitglied[index], konto)
        konto = "{:.2f}€".format(konto)

        now = datetime.now()
        date = now.strftime("%d/%m/%Y %H:%M:%S")
        self._historiedao.create_content(date, 'Listenzahlung', self._nutzermodel._names[index], geld)
        #logging.warning(f'Listenzahlung von: {self._nutzermodel._names[index]} Betrag: {geld}')

        self._nutzermodel._konto[index] = konto
        self._nutzerkassenmodel.editNutzer(index, self._nutzermodel._names[index], konto, self._nutzermodel._mitglied[index],self._nutzermodel._bild[index])

    @pyqtSlot(str)
    def payBar(self, geld):
        kasse = self._kassendao.select_geld()
                
        now = datetime.now()
        date = now.strftime("%d/%m/%Y %H:%M:%S")
        self._historiedao.create_content(date, 'Barzahlung', '-', geld)
        #logging.warning(f'Barzahlung von: - Betrag: {geld}')

        if '€' in geld:
            geld = geld.replace('€', '')
        if ',' in geld:
            geld = geld.replace(',', '.')
        neuKasse = "{:10.2f}".format(float(kasse) + float(geld))
        self._kassendao.edit_geld(neuKasse)

    @pyqtSlot(int, str)
    def updateBestand(self, bestand, artikel):
        product = self._artikeldao.select_article(artikel)
        self._artikeldao.edit_article(artikel, artikel, product[0]['Bild'], product[0]['Mitglieder_Preis'], product[0]['Besucher_Preis'], product[0]['Ist_Kasten'], bestand, product[0]['Kasten_Size'])

    @pyqtSlot(str)
    def removeFromOrder(self, artikel):
        print(artikel)
        product = self._artikeldao.select_article(artikel)
        self._artikeldao.edit_article(artikel, artikel, product[0]['Bild'], product[0]['Mitglieder_Preis'], product[0]['Besucher_Preis'], product[0]['Ist_Kasten'], product[0]['Bestand'] + 1, product[0]['Kasten_Size'])
    
