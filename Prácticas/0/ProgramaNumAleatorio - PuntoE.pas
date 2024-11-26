{
e) Modifique el programa para que imprima números
aleatorios en el rango (A,B) hasta que se genere un
valor igual a F, el cual no debe imprimirse. F, A y B
son números enteros que se leen por teclado.
}
program ProgramaNumAleatorio;

var ale, aux ,A, B, F: integer; {Variables}

begin
     randomize; {Elige una semilla distinta cada vez que se ejecuta el programa.}
                {La semilla sirve para generar series de números aleatorios distintos.}
                {Sin la llamada al procedimiento randomize, en todas las ejecuciones
                 del programa se elige siempre la misma serie de números aleatorios.}
      writeln('Coloque un rango de numeros para generar de manera aleatoria...');
      write('Desde: '); readln(A);
      write('Hasta: '); readln(B);
      writeln('¿Que numero no puede generarse?: ');readln(F);
      aux:= B-A;
      ale := A + random (aux+1); {devuelve un valor aleatorio entre A y B}
     while (ale<>F) do begin
		writeln ('El numero aleatorio generado es: ', ale);
		ale := A + random (aux+1); {devuelve un valor aleatorio entre A y B}
	 end;
	 writeln ('Presione cualquier tecla para finalizar');
     readln;
end.
