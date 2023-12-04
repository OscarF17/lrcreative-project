from flask import Flask, render_template, request, url_for, session, redirect
from flask_mysqldb import MySQL 
from werkzeug.security import check_password_hash, generate_password_hash
from werkzeug.utils import secure_filename
import os, io

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

@app.route('/productos/<string:id>')
def productos(id):
  mensaje = request.args.get('success', 'none')
  print(mensaje)
  cursor = mysql.connection.cursor()
  cursor.execute('SELECT * FROM Producto WHERE id=%s', [id])
  producto = cursor.fetchone()
  # print(producto)
  return render_template('productos.html', producto=producto, mensaje=mensaje)

@app.route('/guardarPedido/<string:id>', methods=['POST'])
def guardarPedido(id):
  color = request.form['color']
  cantidad = request.form['cantidad']
  nombre = request.form['nombre']
  email = request.form['email']
  calle1 = request.form['calle1']
  calle2 = request.form['calle2']
  ciudad = request.form['ciudad']
  codigo = request.form['codigo']
  telefono = request.form['telefono']
  metodo = request.form['metodo']
  file = request.files['archivo']

  # Guardar pedido en la base de datos
  cursor = mysql.connection.cursor()
  cursor.callproc('crearPedido', [nombre, email, calle1, calle2, ciudad, codigo, telefono, metodo])
  mysql.connection.commit()

  # Obtener el ID del pedido que se acaba de guardar
  # Como el ID es autoincremental, debe de ser el más grande
  cursor.execute('SELECT MAX(id) FROM Pedido')
  id_pedido = cursor.fetchone()[0]

  # Relacionar pedido con producto 
  cursor.callproc('crearDetalle', [id_pedido, id, cantidad, color])
  mysql.connection.commit()


  # Guardar imagen en sistema para poder desplegarla
  # Guardar con el id del pedido
  file.save('./static/images/imagenes-usuarios/'+str(id_pedido)+'.jpg')

  return redirect('/productos/'+str(id)+'?success=True')
  

@app.route('/conocenos')
def conocenos():
  return render_template('conocenos.html')

@app.route('/faq')
def faq():
  return render_template('faq.html')

@app.route('/loginAdmin', methods=['POST'])
def loginAdmin():
    
    # Conseguir todo del forms
    nombreAdmin = request.form['nombreAdmin']
    password = request.form['password']

    # Conecta con la base de datos
    cursor = mysql.connection.cursor()

    # Busca al usuario en la base de datos
    cursor.execute("SELECT id, nombre, password, mail FROM Usuario WHERE nombre = %s", (nombreAdmin,))
    usuario = cursor.fetchone()

    # Cerrar Cursor
    cursor.close()

    # Verifica la existencia del usuario y verificar contraseña
    if usuario and check_password_hash(usuario[2], password): # CHECAR HASH
        
        # Establece la información del usuario en la sesión
        session['user_info'] = {'id': usuario[0], 'nombre': usuario[1], 'correo': usuario[3]}
        
        return render_template('admin.html')
    else:
        return redirect(url_for('/login'))

if __name__ == '__main__':
    app.run(debug=True)
