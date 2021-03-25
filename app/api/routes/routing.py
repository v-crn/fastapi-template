from fastapi import APIRouter
from app.config.api_config import PROJECT_NAME


router = APIRouter()


@router.get("/")
async def get():
    return f"text: This is {PROJECT_NAME}"
