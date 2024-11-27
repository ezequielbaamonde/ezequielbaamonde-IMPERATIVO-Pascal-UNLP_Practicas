{3.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 300
y menores a 1550 (incluidos ambos).

b. Un módulo que reciba el vector generado en a) y lo retorne ordenado. (Utilizar lo realizado
en la práctica anterior)

c. Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente
encabezado:
	Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
 Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra
	   en el vector
}

program recursividad2;
const min = 300;
	  max = 1550;
	  dimF = 20;
type 
	 indice = 1..20;
	 vectorRandom = array [indice] of integer;

procedure cargarVector(var v: vectorRandom; var dimL: integer);
 var valor, aux: integer;
 begin
	aux:= max - min;
	valor:= min + random(aux+1);
	if (dimL<=dimF) then begin
		dimL:= dimL+1;
		v[dimL]:= valor;
		cargarVector(v, dimL);
	end;
 end;

procedure insercion(var v: vectorRandom);
 var j, i, num: integer;
 begin
	for i:= 2 to dimF do begin
		num:= v[i]; //se utiliza como condicion y también para intercambio
		j:= i-1;
		while (j>0) and (v[j]>num) do begin
			v[j+1]:= v[j];
			j:= j-1;
		end;
		v[j+1]:= num;
	end;
 end;
 

procedure busquedaDicotomica (v: vectorRandom; ini, fin: indice; dato: integer; var pos: integer); 
 var medio: integer;
 begin
	medio:=(fin+ini) div 2;
	while (ini<=fin) and (dato <> v[medio]) do begin
		if (dato<medio) then fin:= medio-1
		else ini:= medio+1;
		medio:= (fin+ini) div 2;
	end;
	if ((ini <= fin) and (dato = v[medio])) then
		pos:= medio
	else pos:= -1; //No está el valor en el vector
 end;
 
//Variables locales prog principal
var vec: vectorRandom; p, j, dimLogica: integer;
	i, f: indice;

//Programa principal
begin
 randomize; dimLogica:= 0;
 cargarVector(vec, dimLogica);
 
 //No lo pide pero para ver el vector
 for j:=1 to dimF do writeln('Valor: ', vec[j]);
 
 insercion(vec);
 //No lo pide pero para ver el vector ordenado
 writeln();
 writeln('VECTOR ORDENADO:');
 for j:=1 to dimF do writeln('Valor: ', vec[j]);
 i:= 1; f:= 20;
 
 busquedaDicotomica(vec, i, f, 400, p);
 writeln('Posicion del valor a buscar (-1 si no esta): ', p);
end.
