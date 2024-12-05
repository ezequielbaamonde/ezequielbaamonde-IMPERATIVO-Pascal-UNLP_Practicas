program parcialTurnoG;

type
	prestamo = record
		num: integer;
		//ISBN: integer; lo leo en una variable para no hacer otro registro prestamo para la lista
		codSocio: integer;
	end;
	
	listaSocios = ^nodoLista;
	nodoLista = record
		dato: prestamo;
		sig: listaSocios;
	end;
	
	arbol = ^nodoArbol;
	nodoArbol = record
		ISBN: integer; //se ordena por este campo
		lista: listaSocios;
		HI: arbol;
		HD: arbol;
	end;
	
	socios = record
		codSocio: integer;
		cantPrestamos: integer;
	end;
	
	listaPrestamos = ^nodoLista2;
	nodoLista2 = record
		dato: socios;
		sig: listaPrestamos;
	end; 
	
procedure leerPrestamo(var p: prestamo; var i: integer);	
 begin
	writeln('Ingrese un codigo de socio (0 para finalizar carga):');
	readln(p.codSocio);
	if (p.codSocio <> 0) then begin
		p.num:= Random(100); //numero del prestamo
		i:= Random(2); //ISBN | Pongo de 0 a 1 solo para corroborar el inciso B facil.
	end;
 end;
 
//INCISO A
procedure agregarAdelante(var l: listaSocios; p: prestamo); 
 var nue: listaSocios;
 begin
  new(nue);
  nue^.dato:= p;
  nue^.sig:= l;
  l:= nue;
 end;
 
procedure generarArbol(var a: arbol; i: integer; p: prestamo);
 begin
	if (a = NIL) then begin
		new (a);
		a^.ISBN:= i;
		a^.lista:= NIL;
		a^.HI:= NIL;
		a^.HD:= NIL;
		agregarAdelante(a^.lista, p);
	end
	else if (a^.ISBN = i) then begin
		agregarAdelante(a^.lista, p)
	end
	else if (a^.ISBN > i) then
		generarArbol(a^.HI, i, p)
	else generarArbol(a^.HD, i, p);
 end; 


procedure agregarSocio(var l: listaPrestamos; c: integer); //agrego adelante los socios
 var nue: listaPrestamos;
 begin
	new (nue);
	nue^.dato.codSocio:= c;
	nue^.dato.cantPrestamos:= 1; //Inicialmente, si agrego al socio, tiene 1 prestamo
	nue^.sig:= l;
	l:= nue;
 end;
 
procedure generarLista(var lis: listaPrestamos; cod: integer);
 begin
	if (lis <> NIL) then begin
		if (lis^.dato.codSocio = cod) then begin//pregunto si el socio ingresado es el mismo al anterior
			lis^.dato.cantPrestamos:= lis^.dato.cantPrestamos + 1;
			writeln('Acumule cantidad para el socio ', cod)
		end
		else agregarSocio(lis, cod); //sino es el mismo, genero un nuevo nodo
	end
	else agregarSocio(lis, cod); //Si es NIL genero un NODO inicial.
 end;
 
procedure generarEstructuras(var arb: arbol; var lis: listaPrestamos);
 var isbn: integer; pres: prestamo; 
 begin
	leerPrestamo(pres, isbn);
	while (pres.codSocio <> 0) do begin
		generarArbol(arb, isbn, pres); //Árbol, ISBN que se ordena y prestamo.
		generarLista(lis, pres.codSocio); //Lista de codigos de socio.
		leerPrestamo(pres, isbn);
	end;
 end;
 
//INCISO B.
function recorrerPrestamos(lis: listaSocios):integer;
 var cant: integer;
 begin
	cant:= 0;
	while (lis <> NIl) do begin
		cant:= cant + 1;
		lis:= lis^.sig; //salto al sig prestamo
	end;
	recorrerPrestamos:= cant;
 end; 
 
procedure prestamos(a: arbol; i: integer; var c: integer);
 begin
	if (a <> NIL) then begin
		if (a^.ISBN = i) then
			c:= recorrerPrestamos(a^.lista)
		else if (a^.ISBN > i) then prestamos(a^.HI, i, c)
		else prestamos(a^.HD, i, c);
	end;
 end;
 
//INCISO C.
procedure recursivo (lis: listaPrestamos; valor: integer; var c: integer);
 begin
	if (lis <> NIL) then begin
		if (lis^.dato.cantPrestamos > valor) then c:= c+1;
		recursivo(lis^.sig, valor, c);
	end;
 end; 
 
var abb: arbol; L: listaPrestamos; I, x, cant: integer;

BEGIN
 randomize;
 abb:= NIL;
 L:= NIL;
 //Inciso A.
 generarEstructuras(abb, L);
 //Inciso B.
 I:= 1; //ISBN
 cant:= 0;
 prestamos(abb, I, cant);
 writeln('Cantidad de prestamos del ISBN ', I, ': ', cant);
 //Inciso C.
 cant:=0;
 X:= 2; //valor a superar
 recursivo(L, X, cant);
 writeln('Cantidad de socios con cantidad de prestamos superiores a ', X, ': ', cant);
END.
	
	
	
