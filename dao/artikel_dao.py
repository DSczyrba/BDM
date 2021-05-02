import os, sqlite3 as sql


class ArtikelDao:
    def __init__(self):
        self.user_db_file = f'{os.getcwd()}/data/data.db'
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
            sql_create_history = "create table history(" \
                                "date varchar constraint history_pk primary key, " \
                                "kategory varchar not null, " \
                                "name     varchar not null, " \
                                "amount   float   not null);"
            sql_create_kasse = "create table history( " \
                            "date varchar constraint history_pk primary key, " \
                            "kategory varchar not null, " \
                            "name     varchar not null, " \
                            "amount   float   not null);"
            sql_cursor.execute(sql_create_article)
            sql_cursor.execute(sql_create_user)
            sql_cursor.execute(sql_create_history)
            sql_cursor.execute(sql_create_kasse)
            sql_connection.commit()
            sql_connection.close()
        self.db_connection = sql.connect(self.user_db_file)
        self.db_cursor = self.db_connection.cursor()

    def create_article(self, name, picture, mitglieder_preis, besucher_preis,
                       is_kasten, kasten_size, active=1, bestand=0):
        try:
            self.db_cursor.execute(f"INSERT INTO article(name, picture, mitglieder_preis, "
                                   f"besucher_preis, is_kasten, active, bestand, kasten_size) "
                                   f"VALUES('{name}', '{picture}', '{mitglieder_preis}', "
                                   f"'{besucher_preis}', {is_kasten}, {active}, {bestand}, {kasten_size});")
            self.db_connection.commit()
            return True
        except sql.IntegrityError:
            return False

    def edit_article(self, old_name, new_name, picture, mitglieder_preis, besucher_preis,
                     is_kasten, bestand, kasten_size, active=1):
        try:
            self.db_cursor.execute(f"UPDATE article "
                                   f"SET name='{new_name}', picture='{picture}', mitglieder_preis={mitglieder_preis}, "
                                   f"besucher_preis={besucher_preis}, is_kasten={is_kasten}, "
                                   f"bestand={bestand}, active={active}, kasten_size={kasten_size} "
                                   f"WHERE name='{old_name}';")
            self.db_connection.commit()
            return True
        except sql.IntegrityError:
            return False

    def delete_article(self, name):
        try:
            print(f"DELETE FROM article WHERE name='{name}';")
            self.db_cursor.execute(f"DELETE FROM article WHERE name='{name}';")
            self.db_connection.commit()
            return True
        except sql.IntegrityError:
            return False

    def select_articles(self):
        sql_query = self.db_cursor.execute(f"SELECT * FROM article;")
        all_articles = []
        for article in sql_query:
            all_articles.append({"Name": article[0], "Bild": article[1], "Mitglieder_Preis": article[5],
                                 "Besucher_Preis": article[4], "Ist_Kasten": article[2],
                                 "Bestand": article[6], "Aktiv": article[7], "Kasten_Size": article[3]})
        return all_articles
    
    def select_article(self, name):
        sql_query = self.db_cursor.execute(f"SELECT * FROM article WHERE name = '{name}';")
        all_articles = []
        for article in sql_query:
            all_articles.append({"Name": article[0], "Bild": article[1], "Mitglieder_Preis": article[5],
                                 "Besucher_Preis": article[4], "Ist_Kasten": article[2],
                                 "Bestand": article[6], "Aktiv": article[7], "Kasten_Size": article[3]})
        return all_articles

    def update_bestand(self, name, bestand):
        self.db_cursor.execute(f"UPDATE article "
                               f"SET bestand={bestand} "
                               f"WHERE name='{name}';")
        self.db_connection.commit()

    def close_db(self):
        self.db_connection.close()
