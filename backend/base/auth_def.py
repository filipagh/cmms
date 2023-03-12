import os
from typing import Optional

from fastapi import Depends, HTTPException, Security
from fastapi.security import APIKeyHeader, OAuth2AuthorizationCodeBearer, APIKeyCookie
from fief_client import FiefAccessTokenInfo, FiefAsync
from fief_client.integrations.fastapi import FiefAuth
from starlette import status
from starlette.requests import Request
from starlette.responses import Response

write_permission = ["write:all", "read:all"]
read_permission = ["write:all", "read:all"]


def custom_auth(permissions: list[str]):
    async def _auth_custom(api_key=Depends(get_api_key),
                           fief_user: Optional[FiefAccessTokenInfo] = Depends(
                               auth2.current_user(optional=True, permissions=permissions)),
                           fief_user2: Optional[FiefAccessTokenInfo] = Depends(
                               auth.current_user(optional=True, permissions=permissions))):
        if api_key is not None:
            for p in permissions:
                if p.find("read") == -1:
                    break
                return api_key
        if fief_user is not None: return fief_user
        if fief_user2 is not None: return fief_user2

        raise HTTPException(401, "missing auth")

    return _auth_custom


api_key_header = APIKeyHeader(name="api_key", scheme_name="api_key", auto_error=False)


def get_api_key(api_key_headerr: str = Security(api_key_header)):
    if api_key_headerr == os.environ['READ_API_KEY']:
        return api_key_headerr


class CustomFiefAuth(FiefAuth):
    client: FiefAsync

    async def get_unauthorized_response(self, request: Request, response: Response):
        redirect_uri = fix_server_protocol(request.url_for("auth_callback"))

        auth_url = await self.client.auth_url(redirect_uri, scope=["openid"])
        raise HTTPException(
            status_code=status.HTTP_307_TEMPORARY_REDIRECT,
            headers={"Location": auth_url},
        )


fief = FiefAsync(
    os.environ['FIEF_CLIENT_HOST'],
    os.environ['FIEF_CLIENT_ID'],
    os.environ['FIEF_CLIENT_SECRET'],
    encryption_key=os.environ['FIEF_ENCRYPTION_KEY'] if os.environ.get("TEST") is None else None,
)
scheme = OAuth2AuthorizationCodeBearer(
    os.environ['FIEF_CLIENT_HOST'] + "/authorize",
    os.environ['FIEF_CLIENT_HOST'] + "/api/token",
    scopes={"openid": "openid", "offline_access": "offline_access"},
    auto_error=False,
)
auth = FiefAuth(fief, scheme)

SESSION_COOKIE_NAME = "user_session"
scheme = APIKeyCookie(name=SESSION_COOKIE_NAME, scheme_name=SESSION_COOKIE_NAME, auto_error=False)
auth2 = CustomFiefAuth(fief, scheme)


def fix_server_protocol(url):
    if os.environ['SSL_SET'] == "true":
        return 'https' + url[4:]
    return url
