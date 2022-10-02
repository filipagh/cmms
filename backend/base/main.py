import os
import uuid
from multiprocessing import Process
from threading import Thread
from time import sleep
from uuid import UUID

from fastapi import FastAPI

from sqlalchemy.orm import Session

import assetmanager.infrastructure.rest_router
from assetmanager.infrastructure.persistance.asset_category_repo import AssetCategoryModel

os.chdir(os.path.dirname(__file__) + '/../')
os.system('alembic upgrade head')

app = FastAPI(debug=True)
app.include_router(assetmanager.infrastructure.rest_router.asset_manager)

@app.get("/")
async def root():
    return {"message": "Hello World"}
#

# @app.get("/hello/{name}")
# async def say_hello(name: str):
#     return {"message": f"Hello {name}"}
