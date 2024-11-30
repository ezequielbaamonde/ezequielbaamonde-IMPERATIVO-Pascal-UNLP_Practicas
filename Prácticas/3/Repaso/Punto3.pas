{a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
Informática y los almacene en una estructura de datos. La información que se lee es legajo,
código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura
generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben
guardarse los finales que rindió en una lista.

b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.

c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
su cantidad de finales aprobados (nota mayor o igual a 4).

c. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

program facultadInformatica;

type
	finales = record
		legajo: integer;
		materia: integer;
		fecha: real;
		nota: integer;
	end;
	
	regLista = record
		materia: integer;
		fecha: real;
		nota: integer;
	end;
	
	listaFinales = ^nodoFinales;
	nodoFinales = record
		dato: regLista;
		sig: listaFinales;
	end;
	
	arbolAlumnos = ^nodoAlumnos;
	nodoAlumnos = record
		legajo: integer;
		lista: listaFinales;
		HI: arbolAlumnos;
		HD: arbolAlumnos;
	end;
	
	listaProm = ^nodoProm;
	nodoProm = record
		legajo: integer;
		prom: real;
		sig: listaProm;
    end;	
    
    
procedure lecturaFinales(var f: finales);
 begin
	f.legajo:= random(101);
	if (f.legajo<>0) then begin
		f.materia:= 1 + random(11); //Del 1 al 10
		f.fecha:= 1 + random(13); //del 1 al 12
		f.nota:= (random(11));
	end;
 end;
 
procedure agregarAdelante(var lis: listaFinales; f: finales);
 var nue: listaFinales;
 begin
	new(nue);
	nue^.dato.materia:= f.materia;
	nue^.dato.fecha:= f.fecha;
	nue^.dato.nota:= f.nota;
	nue^.sig:= lis;
	lis:= nue;
 end; 
 
procedure cargarArbol(var a: arbolAlumnos; f: finales);
 begin
	if (a = NIL) then begin
		new(a);
		a^.legajo:= f.legajo;
		a^.lista:= NIL;
		a^.HI:= NIL;
		a^.HD:= NIL;
		agregarAdelante(a^.lista, f);
	end
	else
	 begin
		if (f.legajo = a^.legajo) then begin
			agregarAdelante(a^.lista, f)
		end
		else
		 begin
			if (a^.legajo > f.legajo) then begin
				cargarArbol(a^.HI, f)
			end
			else cargarArbol(a^.HD, f);
		 end
	 end
 end;
 
 
procedure generarArbol(var a: arbolAlumnos);
 var fin: finales;
 begin
	lecturaFinales(fin);
	while (fin.legajo <> 0) do begin
		cargarArbol(a, fin);
		lecturaFinales(fin);
	end;
 end;

{b.}
procedure impares (a: arbolAlumnos; var i: integer);
 begin
	if (a<>NIL) then begin
	    if ((a^.legajo mod 2) <> 0) then i:= i +1;
	    impares(a^.HI, i);
		impares(a^.HD, i);
	end;
 end;

function evaluarLista(l: listaFinales):integer;
 var apr: integer;
 begin
	apr:= 0;
	while (l<>NIL) do begin
		if (l^.dato.nota >= 0) then apr:= apr + 1;
		l:= l^.sig;
	end;
	evaluarLista:= apr;
 end;


{c.}
procedure finalesAprobados(a: arbolAlumnos);
 begin
	if (a<>NIL) then begin
		finalesAprobados(a^.HI);
		writeln('Legajo ', a^.legajo, ' tiene ', evaluarLista(a^.lista), ' finales aprobados.');
		finalesAprobados(a^.HD);
	end;
 end;

{d.}
function recorrerFinales(l: listaFinales): real;
 var promedio: real; i: integer;
 begin
    promedio:= 0; i:=0;
	while (l <> NIL) do begin
		promedio:= promedio + l^.dato.nota;
		i:= i+1;
		l:= l^.sig;
	end;
	recorrerFinales:= (promedio/i);
 end;

{d}
procedure agregarAlumno(var lis: listaProm; leg: integer; p: real);
 var nue: listaProm;
 begin
	new(nue);
	nue^.legajo:= leg; nue^.prom:= p;
	nue^.sig:= lis;
	lis:= nue;
 end;

{d}
procedure promedios(a: arbolAlumnos; var l: listaProm; valor: real);
 var leg: integer; prom: real;
 begin
	if (a<>NIL) then begin
		promedios(a^.HD, l, valor);
		prom:= recorrerFinales(a^.lista);
		if (prom > valor) then begin
			leg:= a^.legajo;
			agregarAlumno(l, leg, prom) //agrego alumno a la lista
		end;	
		promedios(a^.HI, l, valor);
	end;
 end;

{d}
procedure imprimirLista(lis: listaProm);
 begin
	while (lis <> NIL) do begin
		writeln('Legajo: ', lis^.legajo, ', Promedio: ',lis^.prom:1:2);
		lis:= lis^.sig;
	end;
 end;

//variables programa principal. 
var abb: arbolAlumnos; imp: integer; lisPromedios: listaProm; x: real;
BEGIN
 randomize;
 abb:= NIL;
 generarArbol(abb);
 imp:= 0; 
 impares (abb, imp);
 writeln('Cantidad de alumnos con legajos impares: ', imp);
 writeln();
 finalesAprobados(abb); //Imprime, por legajo, la cant finales aprobados de c/u
 writeln();
 lisPromedios:= NIL;
 x:= 5.0;
 promedios(abb, lisPromedios, x);
 imprimirLista(lisPromedios);
END.
	
