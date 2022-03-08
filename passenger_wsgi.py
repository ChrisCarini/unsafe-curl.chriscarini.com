import sys, os

print("os.getcwd() = ", os.getcwd())

INTERP = "{cwd}/venv/bin/python3".format(cwd=os.getcwd())
# INTERP is present twice so that the new Python interpreter knows the actual executable path
if sys.executable != INTERP:
    os.execl(INTERP, INTERP, *sys.argv)

sys.path.append(os.getcwd())

# noinspection PyUnresolvedReferences
from app import app as application
