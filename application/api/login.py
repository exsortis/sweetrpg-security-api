__author__ = "Paul Schifferer <dm@sweetrpg.com>"
"""
"""

from datetime import datetime, timedelta
from flask import jsonify, request, current_app
import jwt
from ..models.user import User
from ..db import db
from . import blueprint


@blueprint.route('/login/', methods=['POST'])
def login():
    data = request.get_json()

    user = User.authenticate(**data)
    if not user:
        return jsonify({'message': 'Invalid credentials', 'authenticated': False}), 401

    token = jwt.encode({
        'sub': user.email,
        'iat': datetime.utcnow(),
        'exp': datetime.utcnow() + timedelta(minutes=30)},
        current_app.config['SECRET_KEY'])
    return jsonify({'token': token.decode('utf-8')})
