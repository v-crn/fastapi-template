from pydantic import BaseModel


class CalcResponse(BaseModel):
    item_id: list[str]
    relational_error_rate: list[float]
    true_value: list[float]
