from fastapi.testclient import TestClient

from app.config.api_config import API_VERSION
from app.main import app
from app.models.api.version_response import VersionResponse

client = TestClient(app)


def test_api_version_local__GETリクエストのステータスコードが200であることを確認する() -> None:
    res = client.get("/version")
    api_version = VersionResponse(**res.json()).api_version
    assert res.status_code == 200, f"Invalid response: {res.status_code}"
    assert api_version == API_VERSION, f"Invalid API_VERSION: {api_version}"
