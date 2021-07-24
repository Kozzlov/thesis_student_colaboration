from mysql.connector import connect

class Database:
    def __init__(self):
        self.connection = connect(host='127.0.0.1',
                                  port='3306',
                                  user='root',
                                  password='password')
        self.cursor = self.connection.cursor()
        self.connection.close()

    def connect_database(self):
        self.connection = connect(host='127.0.0.1',
                                  port='3306',
                                  user='root',
                                  password='password')
        self.cursor = self.connection.cursor()

    def register_user_personal_data(self, first_name, last_name, user_name, user_password, user_role):
        self.connect_database()
        self.cursor.execute("""INSERT INTO application_user (first_name, last_name, user_name, user_password, user_role)
        VALUES (%s, %s, %s, %s, %s, 0);""", (first_name, last_name, user_name, user_password, user_role))
        self.connection.commit()
        result = self.cursor.lastrowid
        self.connection.close()
        return result

    def register_user_skills(self, skill_name, skill_type):
        self.connect_database()
        self.cursor.execute("""INSERT INTO skill (skill_name, skill_type)
        VALUES (%s, %s, 0);""", (skill_name, skill_type))
        self.connection.commit()
        result = self.cursor.lastrowid
        self.connection.close()
        return result

    # post information about new project (to-do) add validation
    def post_project_information(self,
                                 project_title,
                                 project_overview,
                                 project_full_description,
                                 project_if_archived,
                                 project_arcivation_date,
                                 project_author):
        if self.cursor.execute(""" SELECT user_id FROM application_user WHERE user_id = %(project_author)s"""):
            self.cursor.execute("""INSERT INTO project (project_title, project_overview, project_full_description, project_if_archived, project_arcivation_date, project_author)
            VALUES (%s, %s, %s, %s, %s, %s, 0);""", (project_title, project_overview, project_full_description, project_if_archived, project_arcivation_date, project_author))
            self.connection.commit()
            result = self.cursor.lastrowid
            self.connection.close()
            return result
        else:
            return "there is no such user, he/she can not host a project"

    # get information about all skills available in the dataset
    # (to-do) dynamically show values from skill table with the following query

    def get_skills(self):
        self.connect_db()
        self.cursor.execute("SELECT skill_name FROM skill order by skill_type")
        result = self.cursor.fetchall()
        self.connection.close()
        return result

    #(TO-DO) application user queries for getting related skills/education history/personal data

