{Una librería requiere el procesamiento de la información de sus productos. De cada producto se conoce el 
código del producto, código de rubro (del 1 al 8) y precio. Implementar un programa que invoque a módulos 
para cada uno de los siguientes puntos:

	a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados por rubro,
		en una estructura de datos adecuada. El ingreso de los productos finaliza cuando se lee el precio 0.
		
	b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
	
	c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que puede haber
		más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3 es mayor a 30, almacenar
		los primeros 30 que están en la lista e ignore el resto.
		
	d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos métodos vistos en la
		teoría.
		
	e. Muestre los precios del vector resultante del punto d).
	
	f. Calcule el promedio de los precios del vector resultante del punto d).}

program Libreria;
type
	sub_rubros = 1..8;
	producto = record
		cod: integer;
		rubro: sub_rubros;
		precio: real;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: producto;
		sig: lista
	end;
	
	vecRubros = array [sub_rubros] of lista;
	vecTres = array [1..30] of producto;

procedure iniVector(var v: vecRubros);
 var i: sub_rubros;
 begin
	for i:= 1 to 8 do v[i]:= NIL;
 end;

procedure leerProd (var p: producto);
 begin
	writeln('Ingrese un precio (-0 para finalizar lectura de productos-): ');
	readln(p.precio);
	if (p.precio <> 0) then begin
		writeln('Ingrese el codigo del producto: ');
		readln(p.cod);
		writeln('Ingrese el rubro del producto (1a8): ');
		readln(p.rubro);
	end;
 end;

procedure insertarOrdenado(var lis: lista; p: producto);
 var ant, act, nue: lista;
 begin
	new (nue);
	nue^.dato:= p;
	ant:= lis;
	act:= lis;
	while (act <> NIL) and (act^.dato.cod < nue^.dato.cod) do begin
		ant:= act;
		act:= act^.sig
	end;
	if (act = ant) then
		lis:= nue
	else
		ant^.sig:= nue;
	nue^.sig:= act;
 end;

procedure cargarVector(var vec: vecRubros);
 var produ: producto;
 begin
	leerProd(produ);
	while (produ.precio <> 0) do begin
		insertarOrdenado(vec[produ.rubro], produ);
		leerProd(produ);
	end;
 end;


procedure mostrar(v: vecRubros);
 var i: sub_rubros;
 begin
	for i:=1 to 8 do begin
		while (v[i] <> nil) do begin
			writeln('Rubro ', i, ' codigo: ', v[i]^.dato.cod);
			v[i]:= v[i]^.sig;
		end;
	end;
 end;


procedure rubro3 (lis: lista; var v3: vecTres);
 var dimL: integer;
 begin
	dimL:=0;
	while (lis <> nil) and (dimL <=30) do begin
		dimL:= dimL+1;
		v3[dimL]:= lis^.dato;
		lis:= lis^.sig;		
	end;
 end;


var vectorRubros: vecRubros; vec3: vecTres;

begin
 iniVector(vectorRubros);
 cargarVector(vectorRubros);
 mostrar(vectorRubros);
 rubro3(vectorRubros[3], vec3);
 //Falta d. e. y f.
end.
