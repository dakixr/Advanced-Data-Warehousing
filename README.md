# ADW - E1 - Desarrollo práctico

## Requerimientos para ejecutar el código correctamente:

- Una BBDD MySQL.
  * Inicializada en el puerto 3306.
  * Con las siguientes credenciales "usuario = adw" y "contraseña = adw" además de darle los permisos necesarios.
    * `mysql> CREATE USER 'adw'@'%' IDENTIFIED BY 'adw';`
    * `mysql> GRANT ALL PRIVILEGES ON *.* TO 'adw'@'%' WITH GRANT OPTION;`
- Tener jq: `sudo apt install jq`.
- Python 3.8 instalado.

## Ejecución de los tests:

Se ha de ejecutar uno de los siguientes comandos, en función del volumen de pruebas que se deseen realiar, desde la raíz del proyecto y los resultados de los test se almacenarán dentro del directorio Resultados en formato json.

```bash
./run-all-tests-json.sh
```
```bash
./run-demo-tests-json.sh
```

Los tiempos (s) se muestran en el siguiente formato: separando InnoDb de MyISAM, agrupando los tiempos con el mismo número de entradas y especificando el número de clientes ejecutando queries de manera simultanea. 
```json
{
  "InnoDB_times": {
    "100 Entradas": {
      "4 Clientes concurrentes": 0.0009200,
      "8 Clientes concurrentes": 0.0012500
    },
    "200 Entradas": {
      "4 Clientes concurrentes": 0.0008500,
      "8 Clientes concurrentes": 0.0009700
    },
    "500 Entradas": {
      "4 Clientes concurrentes": 0.0008500,
      "8 Clientes concurrentes": 0.0012200
    },
    "600 Entradas": {
      "4 Clientes concurrentes": 0.0007500,
      "8 Clientes concurrentes": 0.0018801
    }
  },
  "MyISAM_times": {
    "100 Entradas": {
      "4 Clientes concurrentes": 0.0067400,
      "8 Clientes concurrentes": 0.0098700
    },
    "200 Entradas": {
      "4 Clientes concurrentes": 0.0006900,
      "8 Clientes concurrentes": 0.0011500
    },
    "500 Entradas": {
      "4 Clientes concurrentes": 0.0092500,
      "8 Clientes concurrentes": 0.0115000
    },
    "600 Entradas": {
      "4 Clientes concurrentes": 0.0082500,
      "8 Clientes concurrentes": 0.0118700
    }
  }
}

```

