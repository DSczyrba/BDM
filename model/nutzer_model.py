from PyQt5.QtCore import pyqtProperty, QCoreApplication, QObject, QUrl

class NutzerModel(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._model = []

    @pyqtProperty(list)
    def model(self):
        return self._model

    # Define the setter of the 'name' property.
    @model.setter
    def model(self, model):
        self._model = model
