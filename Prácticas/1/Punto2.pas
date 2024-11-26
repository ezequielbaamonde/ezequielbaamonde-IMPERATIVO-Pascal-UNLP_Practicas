{
2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de 
las expensas de dichas oficinas. 
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina 
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura 
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la 
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}
program ejerc2;

const dimF = 300;

type oficinas = 0..dimF;
		
		 ofi = record
			codId: integer;
			dni: integer;
			expensa: real;
		 end;
		 
		vector = array [1..dimF] of ofi;

{LECTURA DEL REGISTRO}
procedure leerInfo(var v:ofi);
 begin
	writeln('Ingrese un codigo de IDENTIFICACION:');
	readln(v.codId);
	if(v.codId <> -1) then begin
		writeln('Ingrese el dni del propietario: '); readln(v.dni);
		writeln('Ingrese el valor de la expensa: '); readln(v.expensa);
	end;
 end;

{MÓDULO DE CARGA VECTOR}
procedure cargarVector (var v: vector; var dimL: oficinas);
	var dato: ofi;
	begin
		dimL:= 0;
		leerInfo(dato);
		while (dato.codId <> -1) and (dimL<=dimF) do begin
			dimL:= dimL + 1;
			v[dimL]:= dato;
			leerInfo(dato);
		end;
	end;

{ordenamiento de INSERCION por codigo de identificación}
procedure insercion (var v: vector; dimL: oficinas);
 var i, j: oficinas; 
		actual: ofi; {dato}
 begin
	for i:= 2 to dimL do begin
		actual:= V[i]; {toma el valor de la posición 2 del vector}
		j:= i-1; {J ahora es una posición antes que "i"}
		while (j>0) and (v[j].codId > actual.codId) do begin {mientras J sea mayor a 0 y el dato.codId de la pos anterior a "i" sea mayor al dato.codId de la pos "i"}
			v[j + 1]:= v[j]; {El vector en la pos j+1 ahora es el dato de la pos J}
			j:= j - 1; {j se decrementa}
		end;
		v[j + 1]:= actual; {j ahora es el anterior nuevamente del dato reemplazado y corre el valor menor a esa pos}
		end;
 end;

{ordenamiento de SELECCIÓN por codigo de identificación}
procedure seleccion (var v: vector; dimL: oficinas);
 var i, j, pos: oficinas; 
		item: ofi; {dato}
 begin
		for i:= 1 to dimL-1 do begin
			pos:= i;
			for j:=i+1 to dimL do
				if (v[j].codId < v[pos].codId) then pos:= j;
				
		  item:= v[pos];
		  v[pos]:= v[i];
		  v[i]:= item;
		end;
 end;
{VARIABLES DEL PROGRAMA}
var dimL: oficinas;
		vectorOfi:vector;
		
BEGIN
	cargarVector(vectorOfi, dimL);
	insercion(vectorOfi, dimL);
	seleccion (vectorOfi, dimL);
	
END.
