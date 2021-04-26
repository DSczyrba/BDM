from PyQt5.QtCore import QAbstractListModel, Qt, pyqtSignal, pyqtSlot, QModelIndex    

class ArtikelModel(QAbstractListModel):

    NameRole = Qt.UserRole + 1
    PreisRole = Qt.UserRole + 2
    PortraitRole = Qt.UserRole + 3

    produktChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.produkte = [
            
        ]

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == ArtikelModel.NameRole:
            return self.produkte[row]["name"]
        if role == ArtikelModel.PreisRole:
            return self.produkte[row]["preis"]
        if role == ArtikelModel.PortraitRole:
            return self.produkte[row]["portrait"]

    def rowCount(self, parent=QModelIndex()):
        return len(self.produkte)

    def roleNames(self):
        return {
            ArtikelModel.NameRole: b'name',
            ArtikelModel.PreisRole: b'preis',
            ArtikelModel.PortraitRole: b'portrait'
        }

    @pyqtSlot(str, str, str)
    def addProdukt(self, name, preis, portrait):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.produkte.append({'name': name, 'preis': preis, 'portrait': portrait})
        self.endInsertRows()

    @pyqtSlot(int, str, str)
    def editProdukt(self, row, name, preis, portrait):
        ix = self.index(row, 0)
        self.produkte[row] = {'name': name, 'preis': preis, 'portrait': portrait}
        self.produktChanged.emit(ix, ix, self.roleNames())

    @pyqtSlot(int)
    def deleteProdukt(self, row):
        self.beginRemoveColumns(QModelIndex(), row, row)
        del self.produkte[row]
        self.endRemoveRows()

class ArtikelModelB(QAbstractListModel):

    NameRole = Qt.UserRole + 1
    PreisRole = Qt.UserRole + 2
    MPreisRole = Qt.UserRole + 3
    PortraitRole = Qt.UserRole + 4
    BestandRole = Qt.UserRole + 5

    produktChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.produkte = [
            
        ]

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == ArtikelModelB.NameRole:
            return self.produkte[row]["name"]
        if role == ArtikelModelB.PreisRole:
            return self.produkte[row]["preis"]
        if role == ArtikelModelB.MPreisRole:
            return self.produkte[row]["mpreis"]
        if role == ArtikelModelB.PortraitRole:
            return self.produkte[row]["portrait"]
        if role == ArtikelModelB.BestandRole:
            return self.produkte[row]["bestand"]

    def rowCount(self, parent=QModelIndex()):
        return len(self.produkte)

    def roleNames(self):
        return {
            ArtikelModelB.NameRole: b'name',
            ArtikelModelB.PreisRole: b'preis',
            ArtikelModelB.MPreisRole: b'mpreis',
            ArtikelModelB.PortraitRole: b'portrait',
            ArtikelModelB.BestandRole: b'bestand'
        }

    @pyqtSlot(str, str, str, str, int)
    def addProdukt(self, name, preis, mpreis, portrait, bestand):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.produkte.append({'name': name, 'preis': preis, 'mpreis': mpreis, 'portrait': portrait, 'bestand': bestand})
        self.endInsertRows()

    @pyqtSlot(int, str, str, str, int)
    def editProdukt(self, row, name, preis, mpreis, portrait, bestand):
        ix = self.index(row, 0)
        self.produkte[row] = {'name': name, 'preis': preis, 'mpreis': mpreis, 'portrait': portrait, 'bestand': bestand}
        self.produktChanged.emit(ix, ix, self.roleNames())

    @pyqtSlot(int)
    def deleteProdukt(self, row):
        self.beginRemoveColumns(QModelIndex(), row, row)
        del self.produkte[row]
        self.endRemoveRows()