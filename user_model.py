from fastapi_camelcase import CamelModel
from typing import Optional


class User(CamelModel):
    user_id: Optional[str] = None
    first_name: Optional[str] = None
    last_name: Optional[str] = None
