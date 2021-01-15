import os, sys, sqlite3 as sql


class NutzerModel:
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
                                "besucher_preis DOUBLE, " \
                                "mitglieder_preis DOUBLE, " \
                                "bestand INTEGER, " \
                                "active TINYINT);"
            sql_cursor.execute(sql_create_article)
            sql_cursor.execute(sql_create_user)
            sql_connection.commit()
            sql_connection.close()
        self.db_connection = sql.connect(self.user_db_file)
        self.db_cursor = self.db_connection.cursor()

    def create_user(self, name, picture, member, active=1, konto=0.00):
        try:
            self.db_cursor.execute(f"INSERT INTO user(name, picture, member, konto, active) "
                               f"VALUES('{name}', '{picture}', {member}, {konto}, {active});")
            self.db_connection.commit()
            return True
        except sql.IntegrityError:
            return False

    def edit_user(self, old_name, new_name, picture, member, active):
        try:
            self.db_cursor.execute(f"UPDATE user "
                                   f"SET name='{new_name}', picture='{picture}', member={member}, active={active} "
                                   f"WHERE name='{old_name}';")
            self.db_connection.commit()
            return True
        except sql.IntegrityError:
            return False

    def delete_user(self, name):
        try:
            self.db_cursor.execute(f"DELETE FROM user WHERE name='{name}';")
            return True
        except sql.IntegrityError:
            return False

    def select_users(self, name):
        element = self.db_cursor.execute(f"SELECT * FROM user;")
        return element

    def transaction(self, name, konto):
        self.db_cursor.execute(f"UPDATE user "
                               f"SET konto={konto}"
                               f"WHERE name={name};")
        self.db_connection.commit()


one_user = NutzerModel()
#if not one_user.create_user("Eric", "Bild", "1"):
#    print("Der Nutzer existiert bereits!")

#if not one_user.edit_user("Ficken", "Eric", "Bild2", "1", "1"):
#    print("Der Nutzer konnte nicht bearbeitet werden!")

if not one_user.delete_user("Eric"):
    print("Nutzer konnte nicht gelöscht werden!")



