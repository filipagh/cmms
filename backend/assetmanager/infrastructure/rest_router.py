from fastapi import APIRouter
from starlette.responses import PlainTextResponse

from assetmanager.application import asset_category_service
from assetmanager.application.model import schema

asset_manager = APIRouter(
    prefix="/assetManager",
    tags=["AssetManager"],
    responses={404: {"description": "Not found"}},
)


@asset_manager.post("/newCategory")
def create_new_main_category(new_category: schema.AssetCategoryNewSchema):
    asset_category_service.create_main_category(new_category)
    return {"message": "Hello World"}
