import uuid

from sqlalchemy import Column, Integer
from sqlalchemy.dialects import postgresql

import base.database
from base.database import Base


class StorageItemModel(Base):
    __tablename__ = "storage_item"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    asset_id = Column(postgresql.UUID(as_uuid=True), nullable=False)
    in_storage = Column(Integer, nullable=False)
    allocated = Column(Integer, nullable=False)


def _get_db():
    return base.database.get_sesionmaker()


def get_storage_items() -> list[StorageItemModel]:
    with _get_db() as db:
        return db.query(StorageItemModel).all()


def save_new(storage_item: StorageItemModel):
    with _get_db() as db:
        db.add(storage_item)
        db.commit()
