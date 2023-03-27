from authmanager.infrastructure.fief.fief_api_client import FiefApiClient
from authmanager.infrastructure.fief.fiefapi.openapi_client.api.users_api import UsersApi


class FiefUsersApi(UsersApi):
    def __init__(self):
        super().__init__(FiefApiClient())
