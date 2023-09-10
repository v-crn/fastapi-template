from pprint import pprint

from fastapi.testclient import TestClient

from app.main import app
from app.models.api.calc_response import CalcResponse

client = TestClient(app)


def test_api_calc_local__正常なPOSTリクエストに対しステータスコード200() -> None:
    data = {
        "item_id": ["jlf0qljmfa", "faj92033", "ppwien23001"],
        "width": [0.335, 0.313, 0.333],
        "height": [0.332, 0.324, 0.333],
        "depth": [0.336, 0.358, 0.333],
    }
    res = client.post(url="/calc", json=data)
    assert res.status_code == 200, f"Invalid response: {res.status_code}"
    calc_response = CalcResponse(**res.json())
    pprint(calc_response.model_dump())
