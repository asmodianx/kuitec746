import uuid

from fastapi import FastAPI, HTTPException
from typing import List

from models.user_model import User
from repositories.user_repository import get_all_users, create_user, get_user, update_user, delete_user

app = FastAPI()


@app.get("/users")
def get_all_users_api() -> List[User]:
    return get_all_users()


@app.post("/users")
def create_user_api(user: User) -> User:
    return create_user(user)


@app.get("/users/{user_id}")
def get_user_api(user_id: str) -> User:
    uid = uuid.UUID(user_id)
    user = get_user(uid)
    return user


@app.put("/users/{user_id}")
def update_user_api(user_id: str, user: User) -> User:
    if user_id != user.user_id:
        raise HTTPException(status_code=400, detail="path id and object id must match")
    return update_user(user)


@app.delete("/users/{user_id}")
def delete_user_api(user_id: str):
    uid = uuid.UUID(user_id)
    delete_user(uid)
