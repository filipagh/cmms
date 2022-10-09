import uuid

from sqlalchemy import Column, ForeignKey, String, DateTime, func, Integer, Text, Boolean, Date, Enum
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import relationship
import base.database
from assetmanager.application.model.schema import AssetCategoryNewSchema
from base.database import Base


class AssetModel(Base):
    __tablename__ = "assets"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    category_id = Column(postgresql.UUID(as_uuid=True), nullable=False)
    name = Column(String)
    description = Column(String)


def _get_db():
    return next(base.database.get_db())


def save_new(asset: AssetModel):
    db = next(base.database.get_db())
    db.add(asset)
    db.commit()
    db.refresh(asset)


def get_assets():
    db = _get_db()
    return db.query(AssetModel).all()
