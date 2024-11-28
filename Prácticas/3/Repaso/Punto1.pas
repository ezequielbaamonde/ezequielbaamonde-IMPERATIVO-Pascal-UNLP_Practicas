{2. Escribir un programa que:
a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar
con el código de producto 0. Un producto puede estar en más de una venta. Se pide:

i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto. Los códigos repetidos van a la derecha.

ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendidas.

iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
las ventas realizadas del producto.

Nota: El módulo debe retornar TRES árboles.}

program arboles;
type 
	ventas = record
		cod: integer;
		fecha: string [10]; //mes
		cantU: integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: ventas;
		HI: arbol;
		HD: arbol;
	end;
	
	arbol2 = ^nodo2;
	nodo2 = record
		cod: integer;
		cantU: integer;
		HI: arbol2;
		HD: arbol2;
	end;
	
	listaV = ^nodolis;
	nodoLis = record
		dato: ventas; //consultar si debe ser de tipo ventas o generar otro record de ventas sin el codigo
		sig: listaV;
	end;
	
	arbol3 = ^nodo3;
	nodo3 = record
		cod: integer; //ordenado por código
		dato: listaV; //lista con ventas
		HI: arbol3;
		HD: arbol3;
	end;

{Génera 3 arboles}
procedure generarArboles(var a1: arbol; var a2: arbol2; var a3: arbol3);

 procedure generarVenta(var v: ventas);
  var vFec: array [0..11] of string = ('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre');
  begin
	v.cod:= random(21); //0..20
	if (v.cod<>0) then begin
		v.fecha:= vFec[random(12)];
		v.cantU:= random(1000);
	end;
  end;	
 
 {ARBOL 1}
 procedure cargarArbol1(var a: arbol; v: ventas);
  begin
	if (a = NIL) then begin
		new(a);
		a^.dato:= v;
		a^.HI:= NIL;
		a^.HD:= NIL;
	end
	else if (v.cod < a^.dato.cod) then cargarArbol1(a^.HI, v)
	else cargarArbol1(a^.HD, v);
 end;
 
 {ARBOL 2}
 procedure cargarArbol2(var a: arbol2; v: ventas);
  begin
	if (a = NIL) then begin
		new(a);
		a^.cod:= v.cod;
		a^.cantU:= v.cantU;
		a^.HI:= NIL;
		a^.HD:= NIL;
	end
	else if (v.cod < a^.cod) then cargarArbol2(a^.HI, v)
	else cargarArbol2(a^.HD, v);
  end; 	
 
 procedure agregarAdelante(var l: listaV; v: ventas);
  var nue: listaV;
  begin
	new(nue);
	nue^.dato:= v;
	nue^.sig:= NIL;
	l:= nue;
  end;
  
 {Ordenado por código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
  las ventas realizadas del producto.}
 procedure cargarArbol3(var a: arbol3; v: ventas);
  begin
	if (a = NIL) then begin
		new(a);
		a^.cod:= v.cod;
		a^.dato:= NIL;
		agregarAdelante(a^.dato, v);
		a^.HI:= NIL;
		a^.HD:= NIL;
	end
	else if (v.cod = a^.cod) then agregarAdelante(a^.dato, v) //si el cod del producto es el mismo lo agrego a la lista
	else if (v.cod < a^.cod) then cargarArbol3(a^.HI, v)
	else cargarArbol3(a^.HD, v);
  end; 	
 
 
 {GENERACIÓN DE ARBOLES 1, 2 Y 3}	
 procedure generarArbol(var arb1: arbol; var arb2: arbol2; var arb3: arbol3);
  var ven: ventas;
  begin
	generarVenta(ven);
	while (ven.cod <> 0) do begin
		cargarArbol1(arb1, ven);
		cargarArbol2(arb2, ven);
		cargarArbol3(arb3, ven);
		generarVenta(ven);
	end;
  end;
 
 {Programa local del procedimiento generarArboles}
 begin
	generarArbol(a1, a2, a3);
 end;
 
var abb1: arbol; abb2: arbol2; abb3: arbol3;
begin
 abb1:= NIL; abb2:= NIL; abb3:= NIL;
 generarArboles(abb1, abb2, abb3);
end.

