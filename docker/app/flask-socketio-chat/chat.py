#!/bin/env python
import signal
from app import create_app, socketio

app = create_app(debug=True)

if __name__ == '__main__':
    socketio.run(app, "0.0.0.0", 5000)
