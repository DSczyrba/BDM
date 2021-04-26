from PyQt5.QtCore import QAbstractListModel, Qt, pyqtSignal, pyqtSlot, QModelIndex    

class HistorieModel(QAbstractListModel):

    DatumRole = Qt.UserRole + 1
    KategorieRole = Qt.UserRole + 2
    NameRole = Qt.UserRole + 3
    BetragRole = Qt.UserRole + 4

    historieChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.historie = []

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == HistorieModel.DatumRole:
            return self.historie[row]["datum"]
        if role == HistorieModel.KategorieRole:
            return self.historie[row]["kategorie"]
        if role == HistorieModel.NameRole:
            return self.historie[row]["name"]
        if role == HistorieModel.BetragRole:
            return self.historie[row]["betrag"]

    def rowCount(self, parent=QModelIndex()):
        return len(self.historie)

    def roleNames(self):
        return {
            HistorieModel.DatumRole: b'datum',
            HistorieModel.KategorieRole: b'kategorie',
            HistorieModel.NameRole: b'name',
            HistorieModel.BetragRole: b'betrag',
        }

    @pyqtSlot(str, str, str, str)
    def addContent(self, datum, kategorie, name, betrag):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.historie.append({'datum': datum, 'kategorie': kategorie, 'name': name, 'betrag': betrag})
        self.endInsertRows()

    @pyqtSlot(int, str, str, str, str)
    def editContent(self, row, datum, kategorie, name, betrag):
        ix = self.index(row, 0)
        self.historie[row] = {'datum': datum, 'kategorie': kategorie, 'name': name, 'betrag': betrag}
        self.historieChanged.emit(ix, ix, self.roleNames())

    @pyqtSlot(int)
    def deleteContent(self, row):
        self.beginRemoveColumns(QModelIndex(), row, row)
        del self.historie[row]
        self.endRemoveRows()