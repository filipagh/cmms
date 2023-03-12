from pydantic import BaseModel


class UserSchemaBASE(BaseModel):
    name: str
    isVerified: bool
    isAdmin: bool


class UserSchema(UserSchemaBASE):
    pass
