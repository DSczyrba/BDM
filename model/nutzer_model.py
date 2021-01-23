from PyQt5.QtCore import pyqtProperty, QObject, QAbstractListModel


class NutzerModel(QObject):
    def __init__(self):
        super(NutzerModel, self).__init__()
        self._names = []
        self._konto = []
        self._mitglied = []
        self._bild = []

    @pyqtProperty(list)
    def names(self):
        return self._names

    @names.setter
    def names(self, names):
        self._names = names

    @pyqtProperty(list)
    def konto(self):
        return self.konto

    @konto.setter
    def konto(self, konto):
        self._konto = konto

    @pyqtProperty(list)
    def mitglied(self):
        return self._mitglied

    @mitglied.setter
    def mitglied(self, mitglied):
        self._mitglied = mitglied

    @pyqtProperty(list)
    def bild(self):
        return self._bild

    @bild.setter
    def bild(self, bild):
        self._bild = bild