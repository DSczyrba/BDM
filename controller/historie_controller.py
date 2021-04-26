from PyQt5.QtCore import *
from dao.nutzer_dao import NutzerDao
from dao.kassen_dao import KassenDao
import os
import numpy as np


class HistorieController(QObject):

    def __init__(self, nutzermodel, nk_model, historiemodel):
        QObject.__init__(self)
        self._nutzerkassenmodel = nk_model
        self._nutzermodel = nutzermodel
        self._historiemodel = historiemodel
        self._nutzerdao = NutzerDao()
        self._kassendao = KassenDao()

    @pyqtSlot()
    def loadTableData(self):
        path ='log'
        list_of_files = []
        content = []

        while self._historiemodel.rowCount() != 0:
            self._historiemodel.deleteContent(0)

        for root, dirs, files in os.walk(path):
            for file in files:
                list_of_files.append(os.path.join(root,file))
        list_of_files.reverse()

        for name in list_of_files:
            with open(name) as f:
                contents = f.read().splitlines()
            for item in contents:
                content.append(item)

        content.sort()
        content.reverse()

        for data in content:
            datum = data[0:20].strip()
            kategorie = data[20:data.find('v')].strip()
            name = data[data.find('von:') + 5:data.find('Betrag:')].strip()
            betrag = data[data.find('Betrag:') + 8:].strip()
            
            self._historiemodel.addContent(datum, kategorie, name, betrag)
    
    @pyqtSlot(str, str, str, str)
    def deleteContent(self, datum, kategorie, name, betrag):
        path ='log'
        list_of_files = []
        content = []

        if '€' in betrag:
            betrag = betrag.replace('€', '')
        if ',' in betrag:
            betrag = betrag.replace(',', '.')

        for root, dirs, files in os.walk(path):
            for file in files:
                list_of_files.append(os.path.join(root,file))
        list_of_files.reverse()

        for name in list_of_files:
            with open(name) as f:
                contents = f.read().splitlines()
            for item in contents:
                if datum in item:
                    continue
                else:
                    content.append(item)
            os.remove(name)
            with open(name, 'w') as f:
                for item in content:
                    f.write(f'{item}\n')
