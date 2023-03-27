from authmanager.infrastructure.fief.fief_api_client import FiefApiClient
from authmanager.infrastructure.fief.fiefapi.openapi_client import RolesApi


class FiefRoleApi(RolesApi):
    def __init__(self):
        super().__init__(FiefApiClient())
