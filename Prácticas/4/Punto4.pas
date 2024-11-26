{
Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:

a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben
ser eficientes para buscar por ISBN.
	i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos
	insertarlos a la derecha.
	ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
	(prestar atención sobre los datos que se almacenan).
	
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.

c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.

d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.

e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.

f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.

g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.

h. Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido.

i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).

j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
}



{
Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:

a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben
ser eficientes para buscar por ISBN.
	i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos
	insertarlos a la derecha.
	ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
	(prestar atención sobre los datos que se almacenan).}
	
	
program biblioteca;

type prestamo = record
		isbn: integer;
		numSocio: integer;
		diaMes: integer; //año 2021
		cantDiasPrestado: integer;
	 end;
	 
	 //a.i
	 arbolPrestamo = ^nodo;
	 nodo = record
		dato: prestamo;
		HI: arbolPrestamo;
		HD: arbolPrestamo;
	 end;

	//a.ii
	//lista
	listaPrestamos = ^tipoLista;
	
	tipoLista = record
		dato: prestamo; //contiene los datos del prestamo
		sig: listaPrestamos;
	end;
	
	//arbol de listas
	arbolLista = ^nodoLis;
	nodoLis = record
		ISBN: integer;
		lista: listaPrestamos;
		HI: arbolLista;
		HD: arbolLista;
	end;

	

//lectura A
procedure leerPrestamo(p: prestamo);
 begin
	p.isbn:= random(100) + 1;
	if(p.isbn <> 0) then begin
		p.numSocio:= random(100) + 1;
		p.diaMes:= random(5000) + 1000;
		p.cantDiasPrestado:= random(100) + 1;
	end;
 end;


//a.i
procedure agregarNodo(var a: arbolPrestamo; p: prestamo);
 begin
	if (a = nil) then begin
		new(a);
		a^.dato:= p;
		a^.HI:= NIL;
		a^.HD:= NIL;
	end
	else if (a^.dato.isbn > p.isbn) then agregarNodo(a^.HI, p)
	else if (a^.dato.isbn < p.isbn) then agregarNodo(a^.HD, p)
	else agregarNodo(a^.HD, p) //si es igual se agrega a la derecha
 end;


procedure agregarAdelante(var l: listaPrestamos; p: prestamo);
 var nue: listaPrestamos;
 begin
	new(nue);
	nue^.dato:= p;
	nue^.sig := NIL;
	if(nue = NIL) then
		l:= nue
	else begin
		nue^.sig:= l;
		l:= nue;
	end;
 end;


//a.ii
procedure agregarNodoLista (var a2: arbolLista; p: prestamo);
 begin
	if (a2 = nil) then begin
		new(a2);
		a2^.isbn:= p.isbn;
		a2^.lista:= NIL; //inicializar
		agregarAdelante(a2^.lista, p);
		a2^.HI:= NIL;
		a2^.HD:= NIL;
	end
	else if (a2^.isbn > p.isbn) then agregarNodoLista(a2^.HI, p)
	else if (a2^.isbn < p.isbn) then agregarNodoLista(a2^.HD, p)
	else agregarAdelante(a2^.lista, p) // Si el ISBN ya existe, agregar a la lista
 end;

//a.i y a.ii
procedure almacenarArbol(var a: arbolPrestamo; var a2: arbolLista; p: prestamo);
 begin
	agregarNodo(a, p);
	agregarNodoLista(a2, p);
 end;



//a.i
procedure genArbol(var a:arbolPrestamo; var a2: arbolLista);
 var pres: prestamo;
 begin
	leerPrestamo(pres);
	while (pres.isbn <> 0) do begin
		almacenarArbol(a, a2, pres);
		leerPrestamo(pres);
	end;
 end;


begin


END.
