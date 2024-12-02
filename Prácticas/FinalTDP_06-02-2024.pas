program finalImperativo; //Escuela Secundaria

type
	metros = 0..400;
	alumnos = record
		nombre: string[50];
		DNI: integer;
		tiempo: real;
	end;
	
	regAlumnos = record
		nombre: string[50];
		DNI: integer;		
	end;
	
	arbol = ^nodoTiempo;
	nodoTiempo = record
		tiempo: real;
		dato: regAlumnos;
		HI: arbol;
		HD: arbol;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: alumnos;
		sig: lista;
	end;
	
	
procedure leerAlumno (var a: alumnos);
 begin
	writeln('DNI alumno:');
	readln(a.DNI);
 	if (a.DNI <> 0) then begin
		writeln('Nombre Alumno:');
		readln(a.nombre);	
		writeln('Tiempo en recorrido:');
		readln(a.tiempo); 	
 	end;
 end;
 
procedure convertir (a: alumnos; var r: regAlumnos);
 begin
	r.nombre:= a.nombre;
	r.DNI:= a.DNI;
 end;
 
 
procedure cargarArbol(var a: arbol; t: real; r: regAlumnos);
 begin
	if (a = NIL) then begin
		new(a);
		a^.tiempo:= t; //se guarda con los decimales default
		a^.dato:= r;
		a^.HI:= NIL;
		a^.HD:= NIL;
	end
	else
	 begin
		if (a^.tiempo > t) then cargarArbol(a^.HI, t, r)
		else cargarArbol(a^.HD, t, r);
	 end;
 end; 
 
procedure generarArbol(var abb: arbol);
 var alum: alumnos; reg: regAlumnos;
 begin
	leerAlumno(alum);
	while (alum.DNI <> 0) do begin
		convertir(alum, reg);
		cargarArbol(abb, alum.tiempo, reg);
		leerAlumno(alum);
	end;
 end; 

procedure cargarListaOrdenada(t: real; reg: regAlumnos; var L: lista);
 var nue, ant, act: lista;
 begin
	new (nue);
	nue^.dato.tiempo:= t; nue^.dato.nombre:= reg.nombre;
	nue^.dato.DNI:= reg.dni;
	act:= L;
	ant:= L;
	while (act <> NIL) and (t > act^.dato.tiempo) do begin
		ant:= act;
		act:= act^.sig;
	end;
	if (act = ant) then
		L:= nue
	else
		ant^.sig:= nue;
	nue^.sig:= act;
 end;


procedure generarLista(a: arbol; var lis: lista; x, y: real);
 begin
	if (a <> NIL) then begin
		if ((x <= a^.tiempo) and (a^.tiempo <= y)) then begin
			cargarListaOrdenada(a^.tiempo, a^.dato, lis); //real, regAlumnos, lista
		end;
		generarLista(a^.HI, lis, x, y);
		generarLista(a^.HD, lis, x, y);
	end;

 end;

procedure impLista(lis: lista);
 begin
	while (lis <> NIL) do begin
		writeln('Tiempo: ', lis^.dato.tiempo:1:2);
		lis:= lis^.sig;
	end;
 end;

procedure rapido (a: arbol; t: real; var n: string; var d: integer);
 begin
	if (a<>NIL) then begin
		if (a^.tiempo < t) then begin
			t:= a^.tiempo;
			n:= a^.dato.nombre;
			d:= a^.dato.DNI;
		end;
		rapido(a^.HI, t, n, d);
		rapido(a^.HD, t, n, d);
	end;
 end;

var abb1: arbol; dni: integer; inf, sup, tVeloz: real; L: lista; nom: string[50];

BEGIN
 //a.
 abb1:= NIL;
 generarArbol(abb1);
 writeln();
 //b.
 inf:= 2.5; sup:= 3.2;
 generarLista(abb1, L, inf, sup);
 writeln('**Imprimiendo LISTA GENERADA...*');
 impLista(L);
 writeln();
 //c.
 nom:= 'nohay'; dni:= 0; tVeloz:= 9999.9;
 rapido(abb1, tVeloz, nom, dni);
 writeln('El alumno ', nom, ', DNI ', dni, ', es el mas rapido del recorrido.');
END.
 
