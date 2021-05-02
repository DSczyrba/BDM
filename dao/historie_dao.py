import os, sqlite3 as sql


class HistorieDao:
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

    def create_content(self, date, kategory, name, amount):
        try:
            self.db_cursor.execute(f"INSERT INTO history(date, kategory, "
                                   f"name, amount) "
                                   f"VALUES('{date}', '{kategory}', '{name}', {amount});")
            self.db_connection.commit()
            return True
        except sql.IntegrityError:
            return False
    
    def delete_content(self, date):
        try:
            self.db_cursor.execute(f"DELETE FROM history WHERE date='{date}';")
            self.db_connection.commit()
            return True
        except sql.IntegrityError:
            return False

    def select_content(self):
        sql_query = self.db_cursor.execute(f"SELECT * FROM history;")
        contents = []
        for content in sql_query:
            contents.append({"Datum": content[0], "Kategorie": content[1], "Name": content[2], "Betrag": content[3]})
        return contents