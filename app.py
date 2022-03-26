from flask import Flask, request, render_template
import textwrap

app = Flask(__name__)


@app.route('/')
def index():
    user_agent = request.headers.get('User-Agent')
    if 'curl' in user_agent:
        return textwrap.dedent(f"""
            #!/bin/sh\n
            _RED=$(tput setaf 1)
            _RESET=$(tput sgr0)
            echo "\n${{_RED}}[PWN'd]${{_RESET}} You just got pwn'd and you did not even know it. :("\n
            exit 1337\n
        """)
    else:
        return render_template('index.html', user_agent=user_agent)
