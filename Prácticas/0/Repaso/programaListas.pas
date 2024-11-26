program listas;

type 
	listaAle = ^nodo;
	nodo = record
		dato: integer;
		sig: listaAle;
	end;

procedure agAdelante(var lis: listaAle; ale: integer);
 var nue: listaAle;
 begin
  new(nue);
  nue^.dato:= ale;
  nue^.sig:= lis;
  lis:= nue;
 end;

procedure cargarLista(var l: listaAle);
 var aux, ale: integer;
 begin
  aux:= 150-100; //max y min
  ale:= 100 + random(aux+1);
  while (ale<>120) do begin
	agAdelante(l, ale);
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

function buscarElemento(l: listaAle; x: integer): boolean;
 var ok: boolean;
 begin
    ok:= false;
	while (l<>NIL) and (ok = false) do begin
		if (l^.dato = x) then ok:= true
		else l:= l^.sig;
	end;
	buscarElemento:= ok;
 end;
 
var lista: listaAle; x: integer;

begin
 randomize;
 lista:= NIL; //inicialización
 cargarLista(lista);
 imprimirLista(lista);
 writeln('Ingrese un numero, entre 100 y 150, para buscar en la lista:');
 readln(x);
 writeln('El elemento esta? ---> ', buscarElemento(lista, x));
end.
