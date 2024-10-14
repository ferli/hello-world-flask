from app import app

def test_hello_world():
    response = app.test_client().get('/')
    assert response.data == b'Hello, World!'
