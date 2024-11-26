{
a) Implemente un módulo CargarVector que cree un vector de enteros
con a lo sumo 50 valores aleatorios. Los valores, generados
aleatoriamente (entre un mínimo y máximo recibidos por parámetro),
deben ser almacenados en el vector en el mismo orden que se
generaron, hasta que se genere el cero.

b) Implemente un módulo ImprimirVector que reciba el vector generago
en a) e imprima todos los valores del vector en el mismo orden que
están almacenados. Qué cambiaría para imprimir en orden inverso?

c) Escriba el cuerpo principal que invoque a los módulos ya
implementados
}


program actividadDos;
const dimF = 50;
type Vector = array[1..dimF] of integer;

procedure inicializarV(var v:Vector);
 var i: integer;
 begin
	for i:= 1 to dimF do
		v[i]:= 0;
 end;

{
INCISO A
}
procedure cargarVector (var vec: Vector; min, max: integer; var dimL: integer);
 var ale, aux:integer;
 begin
	dimL:=0;
	aux:= (max-min);
	randomize;{Elige una semilla distinta cada vez que se ejecuta el programa.}
                {La semilla sirve para generar series de números aleatorios distintos.}
                {Sin la llamada al procedimiento randomize, en todas las ejecuciones
                 del programa se elige siempre la misma serie de números aleatorios.}
                 
	ale:= min + random (aux+1); {inicio de MIN y busco numeros aleatorios hasta max}
	while (ale<>0) and (dimL<dimF) do begin
		dimL:= dimL + 1;
		vec[dimL]:= ale; 
		ale:= min + random (aux+1); {inicio de MIN y busco numeros aleatorios hasta max}
	end;
 end;

{
INCISO B
}

procedure imprimirVector(var vec: Vector; dimL: integer);
 var i: integer;
 begin
	for i:=1 to dimL do
		writeln('Numero ', i,':', vec[i]); {imprime los valores del vector}
 end;
 
 
{
PROGRAMA PRINCIPAL
}
var v: Vector; minimo, maximo: integer; dimLog: integer;


begin
	minimo:= 100;
	maximo:= 200;
	inicializarV(v);
	cargarVector(v, minimo, maximo, dimLog);
	imprimirVector(v, dimLog);
end.
