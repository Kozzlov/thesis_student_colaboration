from flask import Flask, render_template, request, redirect
from utils.database import Database
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)
database = Database()


@app.route('/')
def index():
    return 'This is index'

@app.route('/user_registration', methods=['GET', 'POST'])
def user_registration():
    return render_template("registration_form.html")
    if request.method == 'POST':
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        user_name = request.form['user_name']
        user_password = request.form['user_password']
        user_role = request.form['user_role']
        if request.form.get("register_button"):
            database.register_user(first_name, last_name, user_name, user_password, user_role)
    return redirect('/')

@app.route('/post_new_project', methods=['GET', 'POST'])
def post_new_project():
    return render_template("project_form.html")



app.run()
