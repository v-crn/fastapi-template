from fastapi import APIRouter

from app.functions import hello_agent
from app.models.api.hello_request import HelloRequest
from app.models.api.hello_response import HelloResponse

router = APIRouter()
summary = "Say hello!"
description = "You can say hello to this api and it will response to you."


@router.post(
    path="/hello",
    tags=["hello"],
    summary=summary,
    description=description,
)
async def post(request: HelloRequest) -> HelloResponse:
    message = hello_agent.say_hello(from_who=request.from_who)
    return HelloResponse(message=message)
