from werkzeug.security import generate_password_hash 

contras = ['contraseña', 'password', 'hola12345', 'password12345', 'contra12345']

for con in contras:
    passw = generate_password_hash(con)
    print(passw)

