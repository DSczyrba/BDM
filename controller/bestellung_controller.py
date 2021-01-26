from dao.nutzer_dao import NutzerDao
from model.nutzer_model import NutzerModel
from PyQt5.QtCore import *

class BestellungController(QObject):

    nutzerDatenAktualisiert = pyqtSignal(list)
    anzeigeDatenAktualiesieren = pyqtSignal(list)

    def __init__(self):
        QObject.__init__(self)
        self._nutzermodel = NutzerModel()
        self._nutzerdao = NutzerDao()

    @pyqtSlot()
    def getUsers(self):
        names = []
        konten = []
        mitglied = []
        bild = []
        user_data = self._nutzerdao.select_users()  #nutzerdaten aus db holen
        print(user_data)
        for i in range(len(user_data)):
            names.append(user_data[i]['Name'])
            konten.append(user_data[i]['Konto'])
            mitglied.append(user_data[i]['Verein'])
            bild.append(user_data[i]['Bild'])

        self._nutzermodel._names = names    #list für combobox setzen
        self._nutzermodel._konto = konten
        self._nutzermodel._mitglied = mitglied
        self._nutzermodel._bild = bild
        print(f'combobox-model: {self._nutzermodel._names}')
        print(f'combobox-model: {self._nutzermodel._konto}')
        print(f'combobox-model: {self._nutzermodel._bild}')
        self.nutzerDatenAktualisiert.emit(self._nutzermodel._names) #funktion onNutzerDatenAktualisiert aufrufen

    @pyqtSlot(int)
    def getCurrentCBData(self, currentIndex):
        konto = self._nutzermodel._konto[currentIndex]
        mitglied = self._nutzermodel._mitglied[currentIndex]
        bild = f'src/{self._nutzermodel._bild[currentIndex]}'

        if konto == 0.0:
            konto = '0.00'
        else:
            "${:,.2f}".format(konto)
        if mitglied == 0:
            mitglied = 'Besucher'
        else:
            mitglied = 'Vereinsmitglied'

        self.anzeigeDatenAktualiesieren.emit([str(konto), str(mitglied), str(bild)])