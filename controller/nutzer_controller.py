import shutil

from dao.nutzer_dao import NutzerDao
from model.nutzer_model import NutzerModel
from PyQt5.QtCore import *
import locale

class NutzerController(QObject):

    imPathAktualisiert = pyqtSignal(str, int)

    def __init__(self, nutzermodel):
        QObject.__init__(self)
        self._nutzermodel = nutzermodel
        self._nutzerdao = NutzerDao()

    @pyqtSlot(str, int)
    def copyImage(self, path, choise):
        path = path.replace('file://', '')
        filename = path.split('/')
        file = f'src/{filename[-1]}'
        print(file)
        shutil.copy(path, f'qml_elements/{file}')
        self.imPathAktualisiert.emit(file, choise)
        
    @pyqtSlot(str, str, str, bool)
    def addUser(self, name, konto, image, member):
        if member:
            member = 1
        else:
            member = 0

        if '€' in konto:
            konto = konto.replace('€', '')
        if ',' in konto:
            konto = konto.replace(',', '.')
        self._nutzerdao.create_user(name, image[4:], member, float(konto))

    @pyqtSlot(int)
    def deleteUser(self, index):
        name = self._nutzermodel.names[index]
        self._nutzerdao.delete_user(name)

    @pyqtSlot(int, str, str, bool)
    def updateUser(self, index, konto, image, member):
        name = self._nutzermodel.names[index]
        print(f'{name}, {konto}, {image}, {member}')
        if member:
            member = 1
        else:
            member = 0

        if '€' in konto:
            konto = konto.replace('€', '')
        if ',' in konto:
            konto = konto.replace(',', '.')
        self._nutzerdao.edit_user(name, image[4:], member, float(konto))