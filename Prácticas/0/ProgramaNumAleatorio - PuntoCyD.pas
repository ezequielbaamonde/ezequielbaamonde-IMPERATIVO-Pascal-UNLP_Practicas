{
d) Modifique el programa para que imprima N números
aleatorios en el rango (A,B), donde N, A y B son
números enteros que se leen por teclado
}

program ProgramaNumAleatorio;

var ale, i, aux ,A, B, N: integer; {Variables}

begin
     randomize; {Elige una semilla distinta cada vez que se ejecuta el programa.}
                {La semilla sirve para generar series de números aleatorios distintos.}
                {Sin la llamada al procedimiento randomize, en todas las ejecuciones
                 del programa se elige siempre la misma serie de números aleatorios.}
      writeln('Coloque un rango de numeros para generar de manera aleatoria...');
      write('Desde: '); readln(A);
      write('Hasta: '); readln(B);
      writeln('¿Cuantos numeros desea que se generen?: ');readln(N);
      aux:= B-A;
     for i:= 1 to N do begin
		ale := A + random (aux+1); {devuelve un valor aleatorio entre A y B}
		writeln ('El numero aleatorio generado es: ', ale);
	 end;
	 writeln ('Presione cualquier tecla para finalizar');
     readln;
end.

{RESPUESTAS:
b) El programa, al ejecutarlo, brinda un número rando

c)     for i:= 1 to 20 do begin
		ale := random (100); devuelve un valor aleatorio en el intervalo 0 a 99
		writeln ('El numero aleatorio generado es: ', ale);
	 end }



