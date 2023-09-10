from pprint import pprint

import requests

from app.config.endpoints import Endpoints
from app.models.api.calc_response import CalcResponse
from tests.config import testconfig_dev
from tests.utils.headers_maker import make_authroized_headers

url = testconfig_dev.API_URL_DEV
endpoint = f"{url}/{Endpoints.calc}"


def test_api_calc_dev__正常なPOSTリクエストに対しステータスコード200() -> None:
    data = {
        "item_id": ["jlf0qljmfa", "faj92033", "ppwien23001"],
        "width": [0.335, 0.313, 0.333],
        "height": [0.332, 0.324, 0.333],
        "depth": [0.336, 0.358, 0.333],
    }
    headers = make_authroized_headers(audience_url=url)
    res = requests.post(url=endpoint, json=data, headers=headers)
    assert res.status_code == 200, f"Invalid response: {res.status_code}"
    calc_response = CalcResponse(**res.json())
    pprint(calc_response.model_dump())
