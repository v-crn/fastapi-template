from fastapi import APIRouter

from app.config.api_config import API_VERSION
from app.models.api.version_response import VersionResponse

router = APIRouter()
summary = "version"
description = "You can get the version of this API from this endpoint."


@router.get(
    path="/version",
    tags=["version"],
    summary=summary,
    description=description,
)
async def get() -> VersionResponse:
    return VersionResponse(api_version=API_VERSION)
