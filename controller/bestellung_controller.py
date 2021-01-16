import sys
from dao.nutzer_dao import NutzerDao
from model.nutzer_model import NutzerModel


class BestellungController:
    def __init__(self):
        self.m_nutzermodel = NutzerModel()
        self.m_nutzerdao = NutzerDao()

    def get_users(self):
        name = []
        user_data = self.m_nutzerdao.select_users()
        for i in user_data:
            name = user_data['name'][i]
            print(name)