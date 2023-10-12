import random
import string

from faker import Faker

import mysql.connector


fake = Faker()

def generate_password(length, alphabet=[
            *string.ascii_lowercase, *string.ascii_uppercase,
            '-', '_', '.', '@', '&']
        ):
    return ''.join([random.choice(alphabet) for _ in range(length)])

def generate_profile_list(n=1):
    genders = {'M': 'male', 'F': 'female'}
    def generate_profile():
        faker_profile = fake.simple_profile()
        first_name, last_name = faker_profile['name'].split()[-2:]
        return {
            'first_name': first_name,
            'last_name': last_name,
            'email': faker_profile['mail'],
            'login': faker_profile['username'],
            'password': generate_password(30),
            'gender': genders[faker_profile['sex']]
        }

    return [generate_profile() for _ in range(n)]

def main():
    connection = mysql.connector.connect(
        host="localhost",
        database="archdb",
        user="stud",
        password="stud",
        port="3360"
    )

    c = connection.cursor()

    values = generate_profile_list(200)
    c.executemany(("INSERT INTO `User` "
        "(`first_name`, `last_name`, `login`, `password`, `email`, `gender`) "
        "VALUES (%(first_name)s, %(last_name)s, %(login)s, %(password)s, %(email)s, %(gender)s)"), values)

    connection.commit();
if __name__ == "__main__":
    main()
