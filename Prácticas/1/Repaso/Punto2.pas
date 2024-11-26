{El administrador de un edificio de oficinas cuenta, en papel, con la información del pago
de las expensas de dichas oficinas. Implementar un programa que invoque a módulos para cada
uno de los siguientes puntos:
	- a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada
	     oficina se ingresa el código de identificación, DNI del propietario y valor de la
	     expensa. La lectura finaliza cuando se ingresa el código de identificación -1, el
	     cual no se procesa.
	- b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
	- c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}
	
program ordenacion;
const
 dimF = 300;
type
 oficina = record
	id: integer;
	dni: integer;
	valor: real;
 end;
 
 vector = array[1..dimF] of oficina;
 
procedure inicializar(var v: vector);
 var i: integer;
 begin
	for i:= 1 to dimF do begin
		v[i].id:= 0;
		v[i].dni:= 0;
		v[i].valor:= 0;
	end;
 end;
 
procedure leerOficina(var o: oficina);
 begin
    writeln('Ingrese un num de identificacion (-1 para no detener carga):');
	readln(o.id);
	if (o.id <> -1) then begin
		writeln('Ingrese un num de DNI:');
		readln(o.dni);
		writeln('Ingrese un valor para la oficina:');
		readln(o.valor);
	end;
 end;
 
procedure cargarVector(var vec: vector; var i: integer);
 var ofi: oficina;
 begin
	i:= 0;
	leerOficina(ofi);
	while (ofi.id <> -1) and (i <= dimF) do begin
		i:= i+1;
		vec[i]:= ofi;
		leerOficina(ofi)
	end;
 end;

procedure insercion(var v: vector; dim: integer);
 var i, j: integer; act: oficina;
 begin
	for i:= 2 to dim do begin
		act:= v[i];
		j:= i-1; //una pos anterior a act
		while (j > 0) and (v[j].id > act.id) do begin
			v[j+1]:= v[j];
			j:= j-1;
		end;
		v[j+1]:= act;
	end;
 end;


var arreglo: vector; i, dimL: integer;

begin
 inicializar(arreglo);
 cargarVector(arreglo, dimL);
 insercion(arreglo, dimL);
 for i:=1 to dimL do writeln(arreglo[i].id);
end.
