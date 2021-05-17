#!/bin/bash

run_test () { # Filas clientes/4 repeticiones
    echo "------------------------------------------------------"
    echo "ventas $1 filas; $(($2*4)) clientes; $3 repeticiones"
    echo "------------------------------------------------------"
    ./run-queries.sh $2 $3
}

declare -a rows=("10000" "50000" "100000" "200000" "400000" "600000" "800000" "1000000")


for j in "${rows[@]}";
do
    python3 data-creator.py $j

    mysql -u adw -padw < InnoDB-schema.sql 2> /dev/null
    mysql -u adw -padw -D CorteIngles < data-CorteIngles.sql 2> /dev/null

    echo "######################################################"
    echo "InnoDB"
    echo "######################################################"

    for i in $( seq 1 10 );
    do
    run_test $j $i 3
    done

    mysql -u adw -padw < MyISAM-schema.sql 2> /dev/null
    mysql -u adw -padw -D CorteIngles < data-CorteIngles.sql 2> /dev/null

    echo "######################################################"
    echo "MyISAM"
    echo "######################################################"

    for i in $( seq 1 10 );
    do
    run_test $j $i 3
    done

done
