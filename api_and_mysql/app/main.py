import dataclasses
from typing import Dict, Optional
import requests
import json
import datetime
import re
import copy
from fastapi import FastAPI, Form, Header

@dataclasses.dataclass
class Response:
    status: str
    body: str

app = FastAPI()

@app.get("/")
def echo(body:Optional[str]=None):
    return {"message":"hello!", "body":body}

