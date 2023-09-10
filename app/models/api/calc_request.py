from pydantic import BaseModel


class CalcRequest(BaseModel):
    item_id: list[str]
    width: list[float]
    height: list[float]
    depth: list[float]
