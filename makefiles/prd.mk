.PHONY: fastapi
fastapi:
	exec uvicorn --port $PORT --host 0.0.0.0 app.main:app
