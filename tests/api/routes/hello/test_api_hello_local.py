from fastapi.testclient import TestClient

from app.main import app
from app.models.api.hello_response import HelloResponse

client = TestClient(app)


def test_api_hello_local__正常なPOSTリクエストに対しステータスコード200() -> None:
    data = {"from_who": "John"}
    res = client.post(url="/hello", json=data)
    assert res.status_code == 200, f"Invalid response: {res.status_code}"
    hello_response = HelloResponse(**res.json())
    print(f"message: {hello_response.message}")
