from pydantic import BaseModel


class HelloRequest(BaseModel):
    from_who: str
