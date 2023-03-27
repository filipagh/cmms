from fastapi import APIRouter, Depends, Request, Response, Query
from fief_client import FiefUserInfo
from starlette.responses import HTMLResponse, RedirectResponse, PlainTextResponse

from authmanager.application.model.schema import UserSchema, Role
from authmanager.infrastructure.fief.fief_role_api import FiefRoleApi
from authmanager.infrastructure.fief.fief_users_api import FiefUsersApi
from authmanager.infrastructure.fief.fiefapi.openapi_client import UserRoleCreate
from base.auth_def import custom_auth, auth2, auth, fix_server_protocol, fief, SESSION_COOKIE_NAME

auth_router = APIRouter(
    prefix="/auth",
    tags=["Auth"],
    responses={404: {"description": "Not found"}},
)


@auth_router.get("/me",
                 response_model=UserSchema)
def get_me(user: FiefUserInfo = Depends(custom_auth(["write:all", "read:all"])),
           permisions=Depends(auth.authenticated(optional=True))):
    role = Role.VERIFIED
    admin = False
    for p in permisions['permissions']:
        if p == "users:manage":
            admin = True
            role = Role.ADMIN
            break
    return UserSchema(id=user['sub'], name=user['email'], isVerified=True, isAdmin=admin, role=role)


@auth_router.get("/users",
                 response_model=list[UserSchema])
def get_all(
        _user: FiefUserInfo = Depends(custom_auth(permissions=["users:manage"])),
):
    col = []
    users = FiefUsersApi().users_list_users_get(limit=1000)

    for u in users.results:
        verifed = False
        admin = False
        role = Role.UNVERIFIED
        for p in FiefUsersApi().users_list_permissions_users_id_permissions_get(u.id).results:
            if p.permission.codename == "users:manage":
                admin = True
                verifed = True
                role = Role.ADMIN
                break
            if p.permission.codename == "write:all":
                verifed = True
                role = Role.VERIFIED

        col.append(UserSchema(id=u.id, name=u.email, isVerified=verifed, isAdmin=admin, role=role))

    return col


@auth_router.post("/user/{user_id}/role", response_class=PlainTextResponse)
def update_user_role(user_id, role: Role, _user: FiefUserInfo = Depends(custom_auth(permissions=["users:manage"]))):
    roles = FiefRoleApi().roles_list_roles_get().results
    user_roles = FiefUsersApi().users_list_roles_users_id_roles_get(user_id).results

    for r in user_roles:
        FiefUsersApi().users_delete_role_users_id_roles_role_id_delete(role_id=r.role_id, id=user_id)

    new_role = None

    if role == Role.ADMIN:
        for r in roles:
            if r.name == "admin":
                new_role = r
                break

    if role == Role.VERIFIED:
        for r in roles:
            if r.name == "verified user":
                new_role = r
                break

    if role == Role.UNVERIFIED:
        return "ok"

    FiefUsersApi().users_create_role_users_id_roles_post(id=user_id, user_role_create=UserRoleCreate(id=new_role.id))

    return "ok"


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

    )
    return response
