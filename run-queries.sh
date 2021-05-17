#!/bin/bash

TIMEFORMAT=%R

if [ $# -ne 2 ]
  then
    echo "Uso: ./run-queries.sh n_clientes/4 n_repeticiones"
    exit 1
fi

rm times.txt 2> /dev/null

for i in $( seq 1 $2 );
do

    for i in $( seq 1 $1 );
    do
        { time mysql -u adw -padw -D CorteIngles -e "SELECT cliente.nombre, sucursal_id, producto_id, producto.nombre, AVG(cantidad) 
        FROM producto, sucursal, cliente, venta
        WHERE producto.id = venta.producto_id 
        AND sucursal.id = venta.sucursal_id
        AND cliente.id = venta.cliente_id
        GROUP BY cliente.nombre, sucursal.id, producto.id, producto.nombre
        ORDER BY AVG(cantidad) DESC; 
        " > /dev/null 2> /dev/null ; } 2>> times.txt &

        { time mysql -u adw -padw -D CorteIngles -e "SELECT cliente.nombre, sucursal_id, producto_id, producto.nombre, AVG(cantidad) 
        FROM producto, sucursal, cliente, venta
        WHERE producto.id = venta.producto_id 
        AND sucursal.id = venta.sucursal_id
        AND cliente.id = venta.cliente_id
        AND sucursal.ciudad like \"Barcelona\"
        GROUP BY cliente.nombre, sucursal.id, producto.id, producto.nombre
        ORDER BY AVG(cantidad) DESC; 
        " > /dev/null 2> /dev/null ; } 2>> times.txt &

        { time mysql -u adw -padw -D CorteIngles -e "SELECT cliente.nombre, sucursal_id, producto_id, producto.nombre, AVG(cantidad) 
        FROM producto, sucursal, cliente, venta
        WHERE producto.id = venta.producto_id 
        AND sucursal.id = venta.sucursal_id
        AND cliente.id = venta.cliente_id
        AND producto.nombre like \"prod1%\" 
        GROUP BY cliente.nombre, sucursal.id, producto.id, producto.nombre
        ORDER BY AVG(cantidad) DESC; 
        " > /dev/null 2> /dev/null ; } 2>> times.txt &

        { time mysql -u adw -padw -D CorteIngles -e "SELECT cliente.nombre, sucursal_id, producto_id, producto.nombre, AVG(cantidad) 
        FROM producto, sucursal, cliente, venta
        WHERE producto.id = venta.producto_id 
        AND sucursal.id = venta.sucursal_id
        AND cliente.id = venta.cliente_id
        AND cliente.nombre like \"A%\"
        GROUP BY cliente.nombre, sucursal.id, producto.id, producto.nombre
        ORDER BY AVG(cantidad) DESC; 
        " > /dev/null 2> /dev/null ; } 2>> times.txt &

    done

    for job in `jobs -p`
    do
        wait $job
    done

done

python3 calc-avg-times.py
