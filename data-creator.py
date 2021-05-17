import random
import sys

n_producto = 1000
n_clientes = 2000
n_sucursal = 30

file = open(f"data-CorteIngles.sql", "w+")

nombres = ["Pepe", "Juan", "Maria", "Mario", "Antonia", "Antonio", "Julio", "Julia", "Daniel", "Daniela", "Guillermo", "Guillermina", "Pedro"]
apellidos = ["Rodriguez", "Gonzalez", "Garcia", "Pavel", "Guitian", "Sanchez"]
ciudades = ["Madrid", "Barcelona", "Valencia", "Bilabao", "Murcia", "Valladolid", "Sevilla"]


def insert_producto(inserts):
    for i in range(0, inserts):
        print(f"INSERT INTO producto (nombre, precio) VALUES (\"{'prod'+str(i)}\",{random.randrange(1, 100)});", file=file)

def insert_cliente(inserts):
    for i in range(0, inserts):
        print(f"INSERT INTO cliente (nombre) VALUES (\"{random.choice(nombres)} {random.choice(apellidos)}\");", file=file)

def insert_sucursal(inserts):
    for i in range(0, inserts):
        print(f"INSERT INTO sucursal (ciudad) VALUES (\"{random.choice(ciudades)}\");", file=file)

def insert_venta(inserts):
    for i in range(0, inserts):
        print("INSERT INTO venta (cantidad, producto_id, cliente_id, sucursal_id) VALUES " +
        f"({random.randrange(1, 100)},{random.randrange(1, n_producto)},{random.randrange(1, n_clientes)},{random.randrange(1, n_sucursal)});", file=file)

if __name__ == '__main__':

    if (len(sys.argv) != 2):
        print("Uso: pyhton3 n_filas_ventas")
        exit(1)

    n_rows = int(sys.argv[1])

    insert_producto(n_producto)
    insert_cliente(n_clientes)
    insert_sucursal(n_sucursal)
    insert_venta(n_rows)
    
    file.close()

