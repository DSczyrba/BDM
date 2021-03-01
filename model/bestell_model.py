from PyQt5.QtCore import QAbstractListModel, Qt, pyqtSignal, pyqtSlot, QModelIndex    

class BestellModel(QAbstractListModel):

    NameRole = Qt.UserRole + 1
    PreisRole = Qt.UserRole + 2

    bestellungChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.bestellung = []

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == BestellModel.NameRole:
            return self.bestellung[row]["name"]
        if role == BestellModel.PreisRole:
            return self.bestellung[row]["preis"]

    def rowCount(self, parent=QModelIndex()):
        return len(self.bestellung)

    def roleNames(self):
        return {
            BestellModel.NameRole: b'name',
            BestellModel.PreisRole: b'preis',
        }

    @pyqtSlot(str, str)
    def addProdukt(self, name, preis):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.bestellung.append({'name': name, 'preis': preis})
        self.endInsertRows()

    @pyqtSlot(int, str, str)
    def editProdukt(self, row, name, preis):
        ix = self.index(row, 0)
        self.bestellung[row] = {'name': name, 'preis': preis}
        self.bestellungChanged.emit(ix, ix, self.roleNames())

    @pyqtSlot(int)
    def deleteProdukt(self, row):
        self.beginRemoveColumns(QModelIndex(), row, row)
        del self.bestellung[row]
        self.endRemoveRows()