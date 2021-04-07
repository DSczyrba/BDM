import os, sys, sqlite3 as sql
from PyQt5 import QtQml
from PyQt5.QtCore import *


class KassenDao:

    def __init__(self):
        #self.m_engine = engine
        self.user_db_file = f'{os.getcwd()}/data/data.db'
        self.signalName = pyqtSignal(str, arguments=["print"])
        if os.path.exists(self.user_db_file):
            pass
        else:
            sql_connection = sql.connect(self.user_db_file)
            sql_cursor = sql_connection.cursor()
            sql_create_user = "CREATE TABLE user(" \
                            "name TEXT PRIMARY KEY, " \
                            "picture TEXT, " \
                            "member TINYINT, " \
                            "konto DOUBLE, " \
                            "active TINYINT);"
            sql_create_article = "CREATE TABLE article(" \
                                "name TEXT PRIMARY KEY , " \
                                "picture TEXT, " \
                                "is_kasten TINYINT, " \
                                "kasten_size INTEGER, " \
                                "besucher_preis DOUBLE, " \
                                "mitglieder_preis DOUBLE, " \
                                "bestand INTEGER, " \
                                "active TINYINT);"
            sql_create_kasse = "CREATE TABLE kasse(geld FLOAT PRIMARY KEY);"
            sql_cursor.execute(sql_create_article)
            sql_cursor.execute(sql_create_user)
            sql_cursor.execute(sql_create_kasse)
            sql_connection.commit()
            sql_connection.close()
        self.db_connection = sql.connect(self.user_db_file)
        self.db_cursor = self.db_connection.cursor()

    def edit_geld(self, geld):
        try:
            self.db_cursor.execute(f"UPDATE kasse "
                                   f"SET geld='{geld}';")
            self.db_connection.commit()
            return True
        except sql.IntegrityError:
            return False

    def select_geld(self):
        sql_query = self.db_cursor.execute(f"SELECT geld FROM kasse;")
        for geld in sql_query:
            return geld[0]

    def close_db(self):
        self.db_connection.close()



#one_user = NutzerModel()
#if not one_user.create_user("Eric", "Bild", "1"):
#    print("Der Nutzer existiert bereits!")

#if not one_user.edit_user("Ficken", "Eric", "Bild2", "1", "1"):
#    print("Der Nutzer konnte nicht bearbeitet werden!")

#if not one_user.delete_user("Eric"):
#    print("Nutzer konnte nicht gelöscht werden!")


#test = one_user.select_users()
#for line in test:
#    print(line)
#one_user.close_db()