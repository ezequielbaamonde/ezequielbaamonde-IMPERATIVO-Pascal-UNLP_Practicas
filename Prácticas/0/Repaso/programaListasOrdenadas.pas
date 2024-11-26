program listasOrdenadas;

type 
	listaAle = ^nodo;
	nodo = record
		dato: integer;
		sig: listaAle;
	end;


procedure insertarOrdenado(var lis: listaAle; dato: integer);
 var ant, act, nue: listaAle;
 begin
	new (nue);
	nue^.dato:= dato;
	nue^.sig:= NIL;
	//1ºCaso
	//Si la lista de entrada esta vacia, lis ahora es el nuevo nodo generado
	if (lis = NIL) then lis:= nue
	else begin //sino
		ant:= lis; act:= lis; //punteros auxiliares
		//BUSCAR POSICIÓN CORRESPONDIENTE donde va el nodo
		while (act<>NIL) and (act^.dato < nue^.dato) do begin
			ant:= act;
			act:= act^.sig;
		end;
		//Si act no se movio, va al principio - 2° caso
		if (act = lis) then begin
			nue^.sig:= lis;
			lis:= nue;
		end
		//Si act no es NIL, está por el medio - 3° y 4º caso
		else begin
			ant^.sig:= nue;
			nue^.sig:= act;
		end;
	end;
 end;

procedure cargarLista(var l: listaAle);
 var aux, ale: integer;
 begin
  aux:= 150-100; //max y min
  ale:= 100 + random(aux+1);
  while (ale<>120) do begin
	insertarOrdenado(l, ale);
	ale:= 100 + random(aux+1);
  end;
 end;
 
procedure imprimirLista(l: listaAle);
 begin
  while(l<>NIL) do begin
	writeln('Valor: ', l^.dato);
	l:= l^.sig;
  end;
 end; 

function buscarElemOrdenado(l: listaAle; x: integer): boolean;
 begin
	while (l<>NIL) and (l^.dato<x) do begin
		l:= l^.sig;
	end;
	if (l^.dato = x) then buscarElemOrdenado:= true
	else buscarElemOrdenado:= false;
 end;
 
var lista: listaAle; x: integer;

begin
 randomize;
 lista:= NIL; //inicialización
 cargarLista(lista);
 imprimirLista(lista);
 writeln('Ingrese un numero entre 100 y 150 para buscar en una lista:');
 readln(x);
 writeln('Esta: ', buscarElemOrdenado(lista, x))
end.
