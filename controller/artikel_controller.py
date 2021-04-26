import shutil

from dao.artikel_dao import ArtikelDao
from model.artikel_model import ArtikelModel
from PyQt5.QtCore import *

class ArtikelController(QObject):

    nutzerDatenAktualisiert = pyqtSignal(list)
    anzeigeDatenAktualiesieren = pyqtSignal(list)
    cbIndexAktualisieren = pyqtSignal(int)
    imPathAktualisiert = pyqtSignal(str)

    def __init__(self, artikelmodel, artikelbmodel):
        QObject.__init__(self)
        self._artikelmodel = artikelmodel
        self._artikelbmodel = artikelbmodel
        self._artikeldao = ArtikelDao()

    @pyqtSlot(str)
    def getArtikel(self, mitglied):
        artikel_data = self._artikeldao.select_articles()  #nutzerdaten aus db holen
        print(artikel_data)
        while self._artikelmodel.rowCount() != 0:
            self._artikelmodel.deleteProdukt(0)
        for i in range(len(artikel_data)):
            if mitglied == 'Vereinsmitglied':
                preis = "{:,.2f}€".format(artikel_data[i]['Mitglieder_Preis'])
            else:
                preis = "{:,.2f}€".format(artikel_data[i]['Besucher_Preis'])            
            self._artikelmodel.addProdukt(artikel_data[i]['Name'], preis, artikel_data[i]['Bild'])

    @pyqtSlot()
    def getArtikelB(self):
        names = []
        bild = []
        artikel = {'name': "", 'preis': 0, 'portrait': ""}
        artikel_data = self._artikeldao.select_articles()  #nutzerdaten aus db holen
        print(artikel_data)
        while self._artikelbmodel.rowCount() != 0:
            self._artikelbmodel.deleteProdukt(0)
        for i in range(len(artikel_data)):
            mpreis = "{:,.2f}€".format(artikel_data[i]['Mitglieder_Preis'])
            preis = "{:,.2f}€".format(artikel_data[i]['Besucher_Preis'])            
            self._artikelbmodel.addProdukt(artikel_data[i]['Name'], preis, mpreis, artikel_data[i]['Bild'], artikel_data[i]['Bestand'])

    @pyqtSlot(str)
    def copyImage(self, path):
        path = path.replace('file://', '')
        filename = path.split('/')
        file = f'src/articles/{filename[-1]}'
        shutil.copy(path, f'qml_elements/{file}')
        self.imPathAktualisiert.emit(file)

    @pyqtSlot(str, str, str, bool, int, str)
    def addArticle(self, name, preis, member_preis, is_kasten, kasten_size, image):
        if is_kasten:
            is_kasten = 1
        else:
            is_kasten = 0

        if '€' in preis:
            preis = preis.replace('€', '')
        if ',' in preis:
            preis = preis.replace(',', '.')
        if '€' in member_preis:
            member_preis = member_preis.replace('€', '')
        if ',' in member_preis:
            member_preis = member_preis.replace(',', '.')

        print(f'{name}, {image[4:]}, {member_preis}, {preis}, {is_kasten}, {kasten_size}')
        self._artikeldao.create_article(name, image, member_preis, preis, is_kasten, kasten_size)

    @pyqtSlot(str, str, str, str)
    def updateArtikel(self, name, preis, mpreis, bestand):
        artikel = self._artikeldao.select_article(name)
        artikel = artikel[0]
        if '€' in preis:
            preis = preis.replace('€', '')
        if ',' in preis:
            preis = preis.replace(',', '.')
        if '€' in mpreis:
            mpreis = mpreis.replace('€', '')
        if ',' in mpreis:
            mpreis = mpreis.replace(',', '.')
        self._artikeldao.edit_article(name, name, artikel['Bild'], mpreis, preis, artikel['Ist_Kasten'], bestand, artikel['Kasten_Size'])

    @pyqtSlot(str)
    def deleteArtikel(self, name):
        self._artikeldao.delete_article(name)