import uuid

import sqlalchemy
from sqlalchemy import Column, String, ForeignKey, text
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session, relationship

import base.database
from assetmanager.domain.model.asset_telemetry import AssetTelemetryType, AssetTelemetryValue
from base.database import Base


class AssetTelemetryModel(Base):
    __tablename__ = "assets_telemetry"
    asset_id = Column(postgresql.UUID(as_uuid=True), ForeignKey("assets.id"), index=True, primary_key=True, )
    type = Column('telemetry_type', sqlalchemy.types.Enum(AssetTelemetryType), nullable=False, primary_key=True, )
    value = Column('telemetry_value', sqlalchemy.types.Enum(AssetTelemetryValue), nullable=False, primary_key=True)


class AssetModel(Base):
    __tablename__ = "assets"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    category_id = Column(postgresql.UUID(as_uuid=True), nullable=False)
    name = Column(String)
    description = Column(String)
    telemetry = relationship("AssetTelemetryModel", lazy="joined")
    is_archived = Column(sqlalchemy.Boolean, nullable=False)


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


def save(model):
    with _get_db() as db:
        db.add(model)
        db.commit()


def search(query):
    query = query + ":*"
    db: Session
    with _get_db() as db:
        return db.query(AssetModel).filter(
            text("unaccent(assets.name) @@    to_tsquery('custom_config', unaccent(:query))")).params(query=query).all()
