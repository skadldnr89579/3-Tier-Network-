from flask import Flask, request, jsonify, render_template, session  # Added session
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)

# A secret key is required to use Flask sessions for cookie encryption.
#app.secret_key = '[your account secret key]'

# [AWS Architecture] DB Configuration
DB_USER = os.environ.get('DB_USER', 'admin')
#DB_PASSWORD = os.environ.get('DB_PASSWORD', '[password set at rds.tf]')
DB_HOST = os.environ.get('DB_HOST', 'localhost')
DB_NAME = os.environ.get('DB_NAME', 'status_db')

app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class StatusLog(db.Model):
    __tablename__ = 'user_status_logs'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    status = db.Column(db.String(50), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.now)

# Main route handling user visits and session-based DB reset
@app.route('/')
def index():
    try:
        # User opens or refreshes the page -> clear the database records
        db.session.query(StatusLog).delete()
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        print(f"Database reset error: {e}")
        
    return render_template('index.html')

@app.route('/api/status', methods=['POST'])
def save_status():
    data = request.json
    new_log = StatusLog(status=data['status'])
    db.session.add(new_log)
    db.session.commit()
    return jsonify({"message": "Saved"}), 201

@app.route('/api/status', methods=['GET'])
def get_statuses():
    logs = StatusLog.query.order_by(StatusLog.created_at.desc()).all()
    output = [{"status": log.status, "created_at": log.created_at.strftime('%Y-%m-%d %H:%M:%S')} for log in logs]
    return jsonify(output), 200

# Acting as an SQL to create table
if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(host='0.0.0.0', port=5000)