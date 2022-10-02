import uuid

from sqlalchemy import Column, ForeignKey, String, DateTime, func, Integer, Text, Boolean, Date, Enum
from sqlalchemy.dialects import postgresql


from base.database import Base


class Verification(Base):
    __tablename__ = "assets"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    # asset_category_id = Column(postgresql.UUID(as_uuid=True), ForeignKey('asset.category.id'), nullable=False)
    asset_category_id = Column(postgresql.UUID(as_uuid=True), nullable=False)
    name = Column(String)
    description = Column(String)
