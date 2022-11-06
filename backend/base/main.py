import os
import uuid
from multiprocessing import Process
from threading import Thread
from time import sleep
from uuid import UUID

from eventsourcing.system import System, MultiThreadedRunner, SingleThreadedRunner
from fastapi import FastAPI

from sqlalchemy.orm import Session
from fastapi.middleware.cors import CORSMiddleware

import assetmanager.infrastructure.rest_router
import storagemanager.infrastructure.rest_router
import roadsegmentmanager.infrastructure.rest_router

from assetmanager.application.asset_projector import AssetProjector
from assetmanager.application.asset_service import AssetService
from roadsegmentmanager.application.road_segment_projector import RoadSegmentProjector
from roadsegmentmanager.application.road_segment_service import RoadSegmentService
from stationmanager.infrastructure.station_rest_router import station_router
from storagemanager.application.storage_item_projector import StorageItemProjector
from storagemanager.application.storage_item_service import StorageItemService

#

os.chdir(os.path.dirname(__file__) + '/../')
os.system('alembic upgrade head')

system = System(pipes=[[AssetService, AssetProjector],
                       [AssetService, StorageItemService],
                       [StorageItemService, StorageItemProjector],
                       [RoadSegmentService, RoadSegmentProjector],

                       ])
runner = SingleThreadedRunner(system)
runner.start()

app = FastAPI(debug=True)
app.include_router(assetmanager.infrastructure.rest_router.asset_manager)
app.include_router(storagemanager.infrastructure.rest_router.storage_manager)
app.include_router(roadsegmentmanager.infrastructure.rest_router.road_segment_manager)
app.include_router(station_router)

origins = [
    "http://localhost:5000",
    "http://localhost:22222",
    "http://pumec.zapto.org:5000",
    "http://pumec.zapto.org:22222",
    "http://192.168.1.3:22222",
]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    return {"message": "Hello World"}
#

# @app.get("/hello/{name}")
# async def say_hello(name: str):
#     return {"message": f"Hello {name}"}
