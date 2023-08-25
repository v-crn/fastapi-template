from fastapi import APIRouter

from app.api.routes import routing


router = APIRouter()
router.include_router(routing.router, tags=["routing"])
