
import requests

from app.config.endpoints import Endpoints
from app.models.api.hello_response import HelloResponse
from tests.config import testconfig_dev
from tests.utils.headers_maker import make_authroized_headers

url = testconfig_dev.API_URL_DEV
endpoint = f"{url}/{Endpoints.hello}"


def test_api_hello_dev__正常なPOSTリクエストに対しステータスコード200() -> None:
    headers = make_authroized_headers(audience_url=url)
    data = {"from_who": "John"}
    res = requests.post(url=endpoint, json=data, headers=headers)
    assert res.status_code == 200, f"Invalid response: {res.status_code}"
    hello_response = HelloResponse(**res.json())
    print(f"message: {hello_response.message}")
