from pydantic import BaseModel


class UserSchemaBASE(BaseModel):
    id: str
    name: str
    isVerified: bool
    isAdmin: bool


class UserSchema(UserSchemaBASE):
    pass
