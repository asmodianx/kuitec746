import os


class EnvConfig:
    _instance = None
    DB_HOST = ""
    DB_USERNAME = ""
    DB_PASSWORD = ""
    DB_NAME = "assignments"
    DB_PORT = "5432"
    SCHEMA = "week9"

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(EnvConfig, cls).__new__(cls)
            cls.DB_HOST = EnvConfig.get_env_variable('DB_HOST')
            cls.DB_USERNAME = EnvConfig.get_env_variable('DB_USERNAME')
            cls.DB_PASSWORD = EnvConfig.get_env_variable('DB_PASSWORD')
            cls.DB_NAME = EnvConfig.get_env_variable('DB_NAME')
            cls.DB_PORT = EnvConfig.get_env_variable('DB_PORT')
            cls.SCHEMA = EnvConfig.get_env_variable('SCHEMA')
        return cls._instance

    def get_env_variable(name: str) -> str:
        try:
            return os.environ[name]
        except KeyError:
            message = "Expected environment variable '{}' not set.".format(name)
            raise Exception(message)
