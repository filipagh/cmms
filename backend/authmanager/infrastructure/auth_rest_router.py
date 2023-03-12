from fastapi import APIRouter, Depends, Request, Response, Query
from fief_client import FiefUserInfo
from starlette.responses import HTMLResponse, RedirectResponse

from authmanager.application.model.schema import UserSchema
from base.auth_def import custom_auth, auth2, auth, fix_server_protocol, fief, SESSION_COOKIE_NAME

auth_router = APIRouter(
    prefix="/auth",
    tags=["Auth"],
    responses={404: {"description": "Not found"}},
)


@auth_router.get("/me",
                 response_model=UserSchema)
def get_me(user: FiefUserInfo = Depends(custom_auth(["write:all", "read:all"]))):
    return UserSchema(name=user['email'], isVerified=True, isAdmin=False)


# @auth_router.get("/users",
#                  response_model=UserSchema)
# def get_all(new_station: schema.StationNewSchema):
#     segment_service = main.runner.get(StationService)
#     return segment_service.create_station(new_station)
#
# @auth_router.post("/",
#                  response_model=UserSchema)
# def create_station(new_station: schema.StationNewSchema):
#     segment_service = main.runner.get(StationService)
#     return segment_service.create_station(new_station)


@auth_router.get("/login", response_class=HTMLResponse)
async def login(
        user: FiefUserInfo = Depends(auth2.current_user()),
):
    return HTMLResponse(
        f"<h1>You are authenticated. Your user email is {user['email']}</h1> <script> window.close() </script>"
    )


@auth_router.get("/auth_test", response_class=HTMLResponse)
async def auth_test(
        user: FiefUserInfo = Depends(custom_auth(permissions=["write:all"])),
):
    return HTMLResponse(
        f"<h1>You are authenticated. with -> {user}</h1>"
    )


@auth_router.get("/logged_out", include_in_schema=False)
async def logged_out(
):
    return HTMLResponse("<h1>You are logged out</h1><script> window.close()</script>")


@auth_router.get("/logout")
async def logout(request: Request
                 ):
    url = await auth.client.logout_url(fix_server_protocol(request.url_for("logged_out")))

    response = RedirectResponse(url)
    response.delete_cookie(
        SESSION_COOKIE_NAME,
    )
    return response


@auth_router.get("/auth-callback", name="auth_callback", include_in_schema=False)
async def auth_callback(request: Request, response: Response, code: str = Query(...)):
    redirect_uri = fix_server_protocol(request.url_for("auth_callback"))
    tokens, _ = await fief.auth_callback(code, redirect_uri)
    response = RedirectResponse(fix_server_protocol(request.url_for("login")))
    response.set_cookie(
        SESSION_COOKIE_NAME,
        tokens["access_token"],
        max_age=tokens["expires_in"],
        httponly=False,
        secure=False,
        # domain="localhost"

    )
    return response
