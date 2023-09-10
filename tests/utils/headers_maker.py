from google.auth.transport.requests import Request
from google.oauth2.id_token import fetch_id_token


def make_authroized_headers(audience_url: str) -> dict[str, str]:
    auth_req = Request()
    id_token = fetch_id_token(request=auth_req, audience=audience_url)
    headers = {"Authorization": f"Bearer {id_token}"}

    return headers
