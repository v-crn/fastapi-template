from fastapi import FastAPI
from fastapi.exceptions import RequestValidationError
from starlette.exceptions import HTTPException

from app.api.errors.http_error import http_error_handler
from app.api.errors.validation_error import http422_error_handler
from app.api.routes.api import router as api_router
from app.config.api_config import API_VERSION, DEBUG, PORT, SERVICE_NAME


def get_app() -> FastAPI:
    app = FastAPI(title=SERVICE_NAME, version=API_VERSION, debug=DEBUG)

    app.add_exception_handler(HTTPException, http_error_handler)
    app.add_exception_handler(RequestValidationError, http422_error_handler)

    app.include_router(api_router)

    return app


app = get_app()

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=PORT, reload=True)
