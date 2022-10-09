import uuid

from sqlalchemy import Column, ForeignKey, String, DateTime, func, Integer, Text, Boolean, Date, Enum
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import relationship
import base.database
from assetmanager.application.model.schema import AssetCategoryNewSchema
from base.database import Base


def save_new(asset_category: AssetCategoryNewSchema):
    model = AssetCategoryModel(
        parent_id=asset_category.parent_id,
        name=asset_category.name,
        description=asset_category.description)
    db = _get_db()
    db.add(model)
    db.commit()
    db.refresh(model)
    return model.id


class AssetCategoryModel(Base):
    __tablename__ = "assets_category"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    children = relationship("AssetCategoryModel")
    parent_id = Column(postgresql.UUID(as_uuid=True), ForeignKey('assets_category.id'), nullable=True)
    name = Column(String)
    description = Column(String)


def _get_db():
    return next(base.database.get_db())


def get_asset_category() -> list[AssetCategoryModel]:
    return _get_db().query(AssetCategoryModel).all()
