from enum import Enum

from pydantic import BaseModel


class Role(str, Enum):
    ADMIN = "admin",
    VERIFIED = "verified",
    UNVERIFIED = "unverified"


class UserSchemaBASE(BaseModel):
    id: str
    name: str
    isVerified: bool
    isAdmin: bool
    role: Role


class UserSchema(UserSchemaBASE):
    pass
