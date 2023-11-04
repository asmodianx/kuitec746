import uuid
from typing import List

from models.user_model import User
from repositories.db_connection import DBConnection

GET_ALL = "SELECT user_id, first_name, last_name from users"
INSERT = "INSERT INTO users (user_id, first_name, last_name) VALUES (%s,%s,%s)"
GET_BY_ID = "SELECT user_id, first_name, last_name from users WHERE user_id = %s"
UPDATE = "UPDATE users set first_name = %s, last_name=%s WHERE user_id = %s"
DELETE = "DELETE FROM users where user_id=%s"


def get_all_users() -> List[User]:
    users = []
    db = DBConnection()
    cur = db.get_cursor()
    cur.execute(GET_ALL)
    for row in cur:
        users.append(User(userId=str(row[0]), firstName=row[1], lastName=row[2]))
    return users


def create_user(user: User) -> User:
    db = DBConnection()
    cur = db.get_cursor()
    uid = uuid.uuid4()
    cur.execute(INSERT, (
        uid,
        user.first_name,
        user.last_name
    ))
    db.connection.commit()
    return get_user(uid)


def get_user(uid: uuid) -> User:
    db = DBConnection()
    cur = db.get_cursor()
    cur.execute(GET_BY_ID, [uid])
    for row in cur:
        user = User(userId=str(row[0]), firstName=row[1], lastName=row[2])
        return user


def update_user(user: User) -> User:
    db = DBConnection()
    cur = db.get_cursor()
    uid = uuid.UUID(user.user_id)
    cur.execute(UPDATE, (user.first_name, user.last_name, uid))
    db.connection.commit()
    return get_user(uid)


def delete_user(uid: uuid):
    db = DBConnection()
    cur = db.get_cursor()
    cur.execute(DELETE, [uid])
    db.connection.commit()
    return
