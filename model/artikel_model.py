from PyQt5.QtCore import QAbstractListModel, Qt, pyqtSignal, pyqtSlot, QModelIndex    

class ArtikelModel(QAbstractListModel):

    NameRole = Qt.UserRole + 1
    PreisRole = Qt.UserRole + 2
    PortraitRole = Qt.UserRole + 3

    produktChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.produkte = [
            { 'name': "Eric", 'preis': 1.50, 'portrait': "src/articles/beer-icon.png"},
            { 'name': "Dominic", 'preis': "1.50€", 'portrait': "src/articles/beer-icon.png"},
            { 'name': "Eric", 'preis': "1.50€", 'portrait': "src/articles/beer-icon.png"},
            { 'name': "Dominic", 'preis': "1.50€", 'portrait': "src/articles/beer-icon.png"},
            { 'name': "Eric", 'preis': "1.50€", 'portrait': "src/articles/beer-icon.png"},
            { 'name': "Dominic", 'preis': "1.50€", 'portrait': "src/articles/beer-icon.png"},
            { 'name': "Eric", 'preis': "1.50€", 'portrait': "src/articles/beer-icon.png"},
            { 'name': "Dominic", 'preis': "1.50€", 'portrait': "src/articles/beer-icon.png"},
            { 'name': "Eric", 'preis': "1.50€", 'portrait': "src/articles/beer-icon.png"},
            { 'name': "Dominic", 'preis': "1.50€", 'portrait': "src/articles/beer-icon.png"}
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

    @pyqtSlot(int, str, str, str)
    def editProdukt(self, row, name, preis, portrait):
        ix = self.index(row, 0)
        self.produkte[row] = {'name': name, 'preis': preis, 'portrait': portrait}
        self.produktChanged.emit(ix, ix, self.roleNames())

    @pyqtSlot(int)
    def deleteProdukt(self, row):
        self.beginRemoveColumns(QModelIndex(), row, row)
        del self.produkte[row]
        self.endRemoveRows()
