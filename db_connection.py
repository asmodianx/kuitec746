import psycopg2
import psycopg2.extras

from config import EnvConfig


class DBConnection:
    _instance = None
    _connection = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(DBConnection, cls).__new__(cls)
        if cls._connection is None:
            config = EnvConfig()
            try:
                cls._connection = psycopg2.connect(
                    dbname=config.DB_NAME,
                    user=config.DB_USERNAME,
                    password=config.DB_PASSWORD,
                    host="192.168.143.91",
                    port=config.DB_PORT,
                    options="-c search_path="+config.SCHEMA)
                print('Database connection opened.')
            except psycopg2.DatabaseError as db_error:
                print("Error: \n{0}".format(db_error))
        return cls._instance

    def __del__(self):
        if self._connection is not None:
            self._connection.close()

    def get_cursor(self):
        cursor = self._connection.cursor()
        psycopg2.extras.register_uuid()
        return cursor

    @property
    def connection(self):
        return self._connection

