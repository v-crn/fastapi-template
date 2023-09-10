import requests
from app.config.api_config import API_VERSION
from app.models.api.version_response import VersionResponse
from tests.config import testconfig_dev
from tests.utils.headers_maker import make_authroized_headers

url = testconfig_dev.API_URL_DEV
endpoint = f"{url}/version"


def test_api_version_dev__GETリクエストのステータスコードが200であることを確認する() -> None:
    headers = make_authroized_headers(audience_url=url)
    res = requests.get(url=endpoint, headers=headers)
    api_version = VersionResponse(**res.json()).api_version
    assert res.status_code == 200, f"Invalid response: {res.status_code}"
    assert api_version == API_VERSION, f"Invalid API_VERSION: {api_version}"
