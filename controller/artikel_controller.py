import shutil

from dao.artikel_dao import ArtikelDao
from model.artikel_model import ArtikelModel
from PyQt5.QtCore import *

class ArtikelController(QObject):

    nutzerDatenAktualisiert = pyqtSignal(list)
    anzeigeDatenAktualiesieren = pyqtSignal(list)
    cbIndexAktualisieren = pyqtSignal(int)
    imPathAktualisiert = pyqtSignal(str)

    def __init__(self, artikelmodel):
        QObject.__init__(self)
        self._artikelmodel = artikelmodel
        self._artikeldao = ArtikelDao()

    @pyqtSlot()
    def getArtikel(self):
        names = []
        bild = []
        artikel_data = self._artikeldao.select_articles()  #nutzerdaten aus db holen
        print(artikel_data)
        for i in range(len(artikel_data)):
            names.append(artikel_data[i]['Name'])
            bild.append(artikel_data[i]['Bild'])

        self._artikelmodel._names = names
        self._artikelmodel._bild = bild

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
        self._artikeldao.create_article(name, image[4:], member_preis, preis, is_kasten, kasten_size)