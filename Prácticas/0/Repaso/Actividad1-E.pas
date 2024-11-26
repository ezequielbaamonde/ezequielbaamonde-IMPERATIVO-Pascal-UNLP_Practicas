program ProgramaNumAleatorio;

var ale, aux, F, A, B: integer;

begin
     randomize; {Elige una semilla distinta cada vez que se ejecuta el programa.}
                {La semilla sirve para generar series de números aleatorios distintos.}
                {Sin la llamada al procedimiento randomize, en todas las ejecuciones
                 del programa se elige siempre la misma serie de números aleatorios.}
                 
     writeln ('Ingrese un numero a igualar aleatoriamente: ');
     readln(F);            
     writeln ('Ingrese un MINIMO para el intervalo: ');
     readln(A); 
     writeln ('Ingrese un MAXIMO para el intervalo: ');
     readln(B); 
     aux:= B-A;
     ale:= A + random(aux+1);
     while (ale<>F) do begin	
		writeln('Numero generado: ', ale);
		ale:= A + random(aux+1);
     end;

     

	 writeln ('Presione cualquier tecla para finalizar');
     readln;
end.

//e) )Modifiqueelprogramaparaqueimprimanúmerosaleatoriosenel
//rango(A,B)hastaquesegenereunvalorigualaF,elcualnodebeimprimirse.F,AyBsonnúmerosenterosqueseleenporteclado.
