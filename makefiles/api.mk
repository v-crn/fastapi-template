.PHONY: api
api:
	exec uvicorn --port ${PORT} --host 0.0.0.0 app.main:app
