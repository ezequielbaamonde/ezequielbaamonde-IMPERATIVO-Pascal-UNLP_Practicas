program ProgramaNumAleatorio;

var ale, aux, i, N, A, B: integer;

begin
     randomize; {Elige una semilla distinta cada vez que se ejecuta el programa.}
                {La semilla sirve para generar series de números aleatorios distintos.}
                {Sin la llamada al procedimiento randomize, en todas las ejecuciones
                 del programa se elige siempre la misma serie de números aleatorios.}
                 
     writeln ('Ingrese una cantidad de numeros a generar: ');
     readln(N);            
     writeln ('Ingrese un MINIMO para el intervalo: ');
     readln(A); 
     writeln ('Ingrese un MAXIMO para el intervalo: ');
     readln(B); 
     aux:= B-A;
     for i:= 1 to N do begin
		ale:= A + random(aux+1);
		writeln('Numero ', i, ' generado: ', ale);
     end;

     

	 writeln ('Presione cualquier tecla para finalizar');
     readln;
end.

//ModifiqueelprogramaparaqueimprimaNnúmerosaleatoriosenelrango(A,B),dondeN,AyB
//sonnúmerosenterosqueseleenporteclado.
