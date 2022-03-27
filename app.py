import textwrap

from flask import Flask, Response, render_template, request

app = Flask(__name__)


@app.route('/')
@app.route('/index.html')
def index() -> Response:
    user_agent = request.headers.get('User-Agent')
    return Response(
        response=render_template('index.html', user_agent=user_agent),
    )


@app.route('/safe_file.sh')
def safe_file() -> Response:
    user_agent = request.headers.get('User-Agent', '')
    if 'curl' in user_agent.lower():
        return unsafe_payload(user_agent=user_agent)
    elif 'wget' in user_agent.lower():
        return unsafe_payload(user_agent=user_agent)
    else:
        return safe_payload(user_agent=user_agent)


def unsafe_payload(user_agent: str) -> Response:
    return create_response(
        payload=textwrap.dedent(
            f"""\
            #!/bin/sh
            
            _RED=$(tput setaf 1)
            _YELLOW=$(tput setaf 3)
            _RESET=$(tput sgr0)
            echo "${{_YELLOW}}[INFO]${{_RESET}} User-Agent: {user_agent}"
            echo
            echo "${{_RED}}[PWN'd]${{_RESET}} You just got pwn'd and you did not even know it. :("
            
            exit 1337
        """
        ),
    )


def safe_payload(user_agent: str) -> Response:
    return create_response(
        payload=textwrap.dedent(
            f"""\
            #!/bin/sh
            
            # Run via:
            #       $ curl -s https://unsafe-curl.chriscarini.com/safe_file.sh | sh
            
            _GREEN=$(tput setaf 2)
            _RESET=$(tput sgr0)
            echo "${{_GREEN}}[INFO]${{_RESET}} User-Agent: {user_agent}\\n"
            
            exit 0
        """
        ),
    )


def create_response(payload: str) -> Response:
    return Response(
        response=payload,
        mimetype='text/plain',
    )
