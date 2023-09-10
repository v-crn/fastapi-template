from fastapi import APIRouter

from app.config.endpoints import Endpoints
from app.functions import calculator
from app.models.api.calc_request import CalcRequest
from app.models.api.calc_response import CalcResponse

router = APIRouter()
summary = "Calc"
description = "You can calculate an error rate of the volume from cubed item data."


@router.post(
    path=f"/{Endpoints.calc}",
    tags=[Endpoints.calc],
    summary=summary,
    description=description,
)
async def post(request: CalcRequest) -> CalcResponse:
    df = calculator.calc_relations_error_rates_as_dataframe(
        item_ids=request.item_id,
        widths=request.width,
        heights=request.height,
        depths=request.depth,
    )
    print(f"\n{df}\n")
    result_dict = df.to_dict(orient="list")
    return CalcResponse(**result_dict)
