from fastapi import APIRouter

from app.api.routes import root, version

router = APIRouter()
router.include_router(root.router)
router.include_router(version.router)
