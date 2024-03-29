from fastapi import APIRouter

from app.api.routes import calc, hello, root, version

router = APIRouter()
router.include_router(root.router)
router.include_router(version.router)
router.include_router(hello.router)
router.include_router(calc.router)
