import uuid

from sqlalchemy import Column, String
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session

import base.database
from base.database import Base


class AssetModel(Base):
    __tablename__ = "assets"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    category_id = Column(postgresql.UUID(as_uuid=True), nullable=False)
    name = Column(String)
    description = Column(String)


def _get_db():
    return base.database.get_sesionmaker()


def save_new(asset: AssetModel):
    with _get_db() as db:
        db.add(asset)
        db.commit()
        db.refresh(asset)


def get_assets():
    with _get_db() as db:
        return db.query(AssetModel).all()


def get_asset_by_id(asset_id) -> AssetModel:
    db: Session
    with _get_db() as db:
        return db.query(AssetModel).get(asset_id)
