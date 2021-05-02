from PyQt5.QtCore import *
from dao.nutzer_dao import NutzerDao
from dao.kassen_dao import KassenDao
from dao.historie_dao import HistorieDao
import os
import numpy as np
from time import gmtime, strftime
import logging


class HistorieController(QObject):

    def __init__(self, nutzermodel, nk_model, historiemodel):
        QObject.__init__(self)
        self._nutzerkassenmodel = nk_model
        self._nutzermodel = nutzermodel
        self._historiemodel = historiemodel
        self._nutzerdao = NutzerDao()
        self._kassendao = KassenDao()
        self._historiedao = HistorieDao()

    @pyqtSlot()
    def loadTableData(self):
        historie = self._historiedao.select_content()

        while self._historiemodel.rowCount() > 0:
            self._historiemodel.deleteContent(0)

        for i in range(len(historie)):        
            self._historiemodel.addContent(historie[i]['Datum'], historie[i]['Kategorie'], historie[i]['Name'], "{:10.2f}".format(float(historie[i]['Betrag'])))
    
    @pyqtSlot(str, str, str, str)
    def deleteContent(self, datum, kategorie, name, betrag):

        if '€' in betrag:
            betrag = betrag.replace('€', '')
        if ',' in betrag:
            betrag = betrag.replace(',', '.')

        if 'Barzahlung' in kategorie:
            kasse = self._kassendao.select_geld()
            self._kassendao.edit_geld("{:10.2f}".format(float(kasse) - float(betrag)))
        
        elif 'Listenzahlung' in kategorie:
            konto = self._nutzermodel._konto
            names = self._nutzermodel._names

            for i in range(len(names)):
                if names[i] in name:
                    self._nutzerdao.edit_user(self._nutzermodel._names[i], self._nutzermodel._bild[i], self._nutzermodel._mitglied[i], "{:10.2f}".format(float(konto[i]) + float(betrag)))

        elif 'Kassenabrechnung' in kategorie or 'Einzahlung' in kategorie:
            if name in 'Kasse':
                kasse = self._kassendao.select_geld()
                self._kassendao.edit_geld("{:10.2f}".format(float(kasse) + float(betrag)))
            else:
                konto = self._nutzermodel._konto
                names = self._nutzermodel._names

                for i in range(len(names)):
                    if names[i] in name:
                        self._nutzerdao.edit_user(self._nutzermodel._names[i], self._nutzermodel._bild[i], self._nutzermodel._mitglied[i], "{:10.2f}".format(float(konto[i]) - float(betrag)))
        
        self._historiedao.delete_content(datum)