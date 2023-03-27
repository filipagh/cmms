import os

from authmanager.infrastructure.fief.fiefapi.openapi_client.api_client import ApiClient
from authmanager.infrastructure.fief.fiefapi.openapi_client.configuration import Configuration


class FiefApiClient(ApiClient):
    def __init__(self):
        super().__init__(Configuration(host=os.environ["FIEF_ADMIN_API"], api_key={
            'fief_admin_session': os.environ["FIEF_ADMIN_API_KEY"]
        }), header_name="Authorization", header_value="Bearer " + os.environ["FIEF_ADMIN_API_KEY"])
