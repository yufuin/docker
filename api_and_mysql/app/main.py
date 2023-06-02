import dataclasses
import json
from fastapi import FastAPI, Form, Header

import mysql_controller as M

@dataclasses.dataclass
class Response:
    status: str
    body: str

app = FastAPI()
db = M.connect()

@app.get("/")
def echo():
    result = M.show_databases(db)
    return {"databases": json.dumps(result)}

