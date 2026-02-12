import os
from pydantic_settings import BaseSettings

BASE_DIR = os.path.dirname(
    os.path.dirname(
        os.path.dirname(os.path.abspath(__file__))
    )
)


class DBConfig(BaseSettings):
    name: str
    host: str
    port: int
    user: str
    password: str

    model_config = {
        "env_prefix": "DB_",
         "env_file": os.path.join(BASE_DIR, ".env"),
        "env_file_encoding": "utf-8",
    }

config = DBConfig()