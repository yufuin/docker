import sys, os
import MySQLdb
from MySQLdb.connections import Connection as DB_type

HOST_SERVER = "mysql_server"
USER = "root"
PASSWORD = os.environ["MYSQL_ROOT_PASSWORD"]

DB_NAME = os.environ["DB_NAME"]


def connect() -> DB_type:
    db = MySQLdb.connect(host=HOST_SERVER, user=USER, password=PASSWORD)
    return db

def get_result(db:DB_type) -> list:
    result = db.store_result()
    if result is not None:
        out = [result.fetch_row() for _ in range(result.num_rows())]
        return out
    else:
        return

def debug_show1(db:DB_type):
    db.query("SHOW DATABASES;")
    return get_result(db)
