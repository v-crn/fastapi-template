from fastapi import APIRouter
from fastapi.responses import RedirectResponse

from app.config.api_config import SERVICE_NAME

router = APIRouter()
summary = "root page"
description = (
    f"This is {SERVICE_NAME}. You will be redirected to the API documentation page."
)


@router.get(
    path="/",
    tags=["root"],
    summary=summary,
    description=description,
)
async def get() -> RedirectResponse:
    print(
        f"This is {SERVICE_NAME}. You will be redirected to "
        "the API documentation page."
    )
    f"""
    This is {SERVICE_NAME}. You will be redirected to
    the API documentation page.
    """
    return RedirectResponse(url="/docs")
