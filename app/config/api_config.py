import os

SERVICE_NAME = os.environ["SERVICE_NAME"]
API_VERSION = os.environ["API_VERSION"]
PORT = int(os.environ["PORT"])
DEBUG: bool = os.environ["DEBUG"] == "True"
