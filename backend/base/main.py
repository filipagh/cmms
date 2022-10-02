import os
import uuid
from uuid import UUID

from fastapi import FastAPI

import alembic.config
from sqlalchemy.orm import Session

from assetmanager.infrastructure.persistance.asset_repo import Verification

os.chdir(os.path.dirname(__file__)+'/../')
alembicArgs = [
    '-c', 'alembic.ini',
    '--raiseerr',
    'upgrade', 'head',
]
alembic.config.main(argv=alembicArgs)

app = FastAPI()


@app.get("/")
async def root():
    v =Verification(asset_category_id=uuid.uuid4(),name="aaa", description="aaaa")
    import database
    db: Session = next(database.get_db())
    db.add(v)
    db.commit()
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}
