__author__ = "Paul Schifferer <dm@sweetrpg.com>"
"""
main.py
- creates a Flask app instance and registers the database object
"""

from flask import Flask
from flask_cors import CORS
# from flask_dotenv import DotEnv


def create_app(app_name='sweetrpg-users'):
    app = Flask(app_name)
    app.config.from_object('application.config.BaseConfig')
    # env = DotEnv(app)

    cors = CORS(app, resources={r"/users/*": {"origins": "*"}})

    from application.api import blueprint, login, register
    print("blueprint:", blueprint)
    app.register_blueprint(blueprint, url_prefix="/users")

    from application.db import db
    db.init_app(app)

    return app
