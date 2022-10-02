from fastapi import FastAPI
from sqlalchemy import  Column

import alembic.config
alembicArgs = [
    '--raiseerr',
    'upgrade', 'head',
]
alembic.config.main(argv=alembicArgs)

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}
