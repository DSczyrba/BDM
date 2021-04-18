from PyQt5.QtCore import pyqtProperty, QObject, QAbstractListModel, Qt, QModelIndex, pyqtSignal, pyqtSlot

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

class NutzerKassenModel(QAbstractListModel):

    NameRole = Qt.UserRole + 1
    KontoRole = Qt.UserRole + 2
    MitgliedRole = Qt.UserRole + 3
    PortraitRole = Qt.UserRole + 4

    nutzerChanged = pyqtSignal(QModelIndex, QModelIndex, dict)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.nutzer = [
            
        ]

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == NutzerKassenModel.NameRole:
            return self.nutzer[row]["name"]
        if role == NutzerKassenModel.KontoRole:
            return self.nutzer[row]["konto"]
        if role == NutzerKassenModel.MitgliedRole:
            return self.nutzer[row]["mitglied"]
        if role == NutzerKassenModel.PortraitRole:
            return self.nutzer[row]["portrait"]

    def rowCount(self, parent=QModelIndex()):
        return len(self.nutzer)

    def roleNames(self):
        return {
            NutzerKassenModel.NameRole: b'name',
            NutzerKassenModel.KontoRole: b'konto',
            NutzerKassenModel.MitgliedRole: b'mitglied',
            NutzerKassenModel.PortraitRole: b'portrait'
        }

    @pyqtSlot(str, str, bool, str)
    def addNutzer(self, name, konto, mitglied, portrait):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.nutzer.append({'name': name, 'konto': konto, 'mitglied': mitglied, 'portrait': portrait})
        self.endInsertRows()

    @pyqtSlot(int, str, str, bool, str)
    def editNutzer(self, row, name, konto, mitglied, portrait):
        ix = self.index(row, 0)
        self.nutzer[row] = {'name': name, 'konto': konto, 'mitglied': mitglied, 'portrait': portrait}
        self.nutzerChanged.emit(ix, ix, self.roleNames())

    @pyqtSlot(int)
    def deleteNutzer(self, row):
        self.beginRemoveColumns(QModelIndex(), row, row)
        del self.nutzer[row]
        self.endRemoveRows()