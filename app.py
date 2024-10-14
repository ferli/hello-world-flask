import os
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, Indonesia!'

if __name__ == '__main__':
    # Use environment variable to determine if we are in production or development
    env = os.getenv('FLASK_ENV', 'development')
    debug = env == 'development'
    
    # If environment is development, debug mode will be enabled
    app.run(debug=debug, host='0.0.0.0')
