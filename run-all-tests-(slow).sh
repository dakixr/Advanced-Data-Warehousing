#!/bin/bash

run_test () { # Filas clientes/4 repeticiones
    echo "------------------------------------------------------"
    echo "ventas $1 filas; $(($2*4)) clientes; $3 repeticiones"
    echo "------------------------------------------------------"
    ./run-test.sh $1 $2 $3
}

for i in $( seq 1 10 );
do
    run_test 10000 $i 2
    run_test 50000 $i 2
    run_test 100000 $i 2
    run_test 200000 $i 2
    run_test 400000 $i 2
    run_test 600000 $i 2
    run_test 800000 $i 2
    run_test 1000000 $i 2
done
