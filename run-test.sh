#!/bin/bash

if [ $# -ne 3 ]
  then
    echo "Uso: ./run-test.sh n_rows_ventas n_clientes/4 n_repeticiones"
    exit 1
fi

python3 data-creator.py $1

mysql -u adw -padw < InnoDB-schema.sql 2> /dev/null
mysql -u adw -padw -D CorteIngles < data-CorteIngles.sql 2> /dev/null

echo "InnoDB (s):"
./run-queries.sh $2 $3


mysql -u adw -padw < MyISAM-schema.sql 2> /dev/null
mysql -u adw -padw -D CorteIngles < data-CorteIngles.sql 2> /dev/null

echo "MyISAM (s):"
./run-queries.sh $2 $3