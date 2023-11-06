from flask import Flask, render_template, request, url_for
from flask_mysqldb import MySQL 

app = Flask(__name__)
mysql = MySQL(app)

# Configuración de la BD
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'web_user'
app.config['MYSQL_PASSWORD'] = 'password'
app.config['MYSQL_DB'] = 'LRCreative'

@app.route('/')
def index():
  return render_template('index.html')

@app.route('/contactanos', methods=['GET', 'POST'])
def contactanos():
  return render_template('contactanos.html')

@app.route('/catalogo')
def catalogo():
  return render_template('catalogo.html')

@app.route('/conocenos')
def conocenos():
  return render_template('conocenos.html')

@app.route('/faq')
def faq():
  return render_template('faq.html')