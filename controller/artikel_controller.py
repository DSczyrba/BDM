from dao.artikel_dao import ArtikelDao
from model.artikel_model import ArtikelModel
from PyQt5.QtCore import *

class ArtikelController(QObject):

    nutzerDatenAktualisiert = pyqtSignal(list)
    anzeigeDatenAktualiesieren = pyqtSignal(list)
    cbIndexAktualisieren = pyqtSignal(int)

    def __init__(self):
        QObject.__init__(self)
        self._artikelmodel = ArtikelModel()
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
        print(f'combobox-model: {self._nutzermodel._names}')
        print(f'combobox-model: {self._nutzermodel._bild}')
        self.nutzerDatenAktualisiert.emit(self._artikelmodel._names) #funktion onNutzerDatenAktualisiert aufrufen
