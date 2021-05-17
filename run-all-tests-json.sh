#!/bin/bash

run_test () { # Filas clientes/4 repeticiones

    echo "\"$(($2*4))\": " >> Resultados/tmp.json
    ./run-queries.sh $2 $3 >> Resultados/tmp.json
}

mkdir "Resultados" 2> /dev/null


echo "{ \"InnoDB_times\": {" > Resultados/tmp.json



declare -a rows=("10000" "50000" "100000" "200000" "400000" "600000" "800000" "1000000")


for j in "${rows[@]}";
do
    python3 data-creator.py $j

    mysql -u adw -padw < InnoDB-schema.sql 2> /dev/null
    mysql -u adw -padw -D CorteIngles < data-CorteIngles.sql 2> /dev/null

	echo " \"$j\": {" >> Resultados/tmp.json
    for i in $( seq 1 10 );
    do
	    run_test $j $i 3
	    if [ $i -ne 10 ]; then
	   		echo "," >> Resultados/tmp.json
	    fi
    done
    echo "}" >> Resultados/tmp.json
    
    if [ $j -ne 1000000 ]; then
	   		echo "," >> Resultados/tmp.json
	fi


done

echo "}, \"MyISAM_times\": {" >> Resultados/tmp.json

for j in "${rows[@]}";
do
    python3 data-creator.py $j

    mysql -u adw -padw < MyISAM-schema.sql 2> /dev/null
    mysql -u adw -padw -D CorteIngles < data-CorteIngles.sql 2> /dev/null

	echo " \"$j\": {" >> Resultados/tmp.json
    for i in $( seq 1 10 );
    do
	    run_test $j $i 3
	    if [ $i -ne 10 ]; then
	   		echo "," >> Resultados/tmp.json
	    fi
    done
    echo "}" >> Resultados/tmp.json
    
    if [ $j -ne 1000000 ]; then
	   		echo "," >> Resultados/tmp.json
	fi


done

echo "} }" >> Resultados/tmp.json


cat Resultados/tmp.json | jq > Resultados/InnoDB-MyISAM.json
rm Resultados/tmp.json


