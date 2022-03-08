from flask import Flask, request
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
        return textwrap.dedent(f"""
            Hello, world!<br/>
            <br/>
            Nothing to see here. 😉<br/>
            <br/>
            ... certainly don't run the below in your terminal.<br/>
            <br/>
            <pre>💻 $ curl -s https://unsafe-curl.chriscarini.com | sh</pre><br/>
            <hr/>
            User-Agent: {user_agent}\n<br/>
        """)
