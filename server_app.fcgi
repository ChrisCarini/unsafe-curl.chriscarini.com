#!/usr/bin/python3
import sys
from pathlib import Path

# This points to the application on the local filesystem.
python_version = sys.version_info
LOCAL_APPLICATION_PATH = str(
    Path.cwd()
    / f"venv/lib/python{python_version.major}.{python_version.minor}/site-packages"
)
sys.path.insert(0, LOCAL_APPLICATION_PATH)

from flup.server.fcgi import WSGIServer  # noqa: E402

from app import app  # noqa: E402


class ScriptNamePatch:
    def __init__(self, app):
        self.app = app

    def __call__(self, environ, start_response):
        environ["SCRIPT_NAME"] = "app.py"
        return self.app(environ, start_response)


app = ScriptNamePatch(app)

if __name__ == "__main__":
    WSGIServer(app).run()
