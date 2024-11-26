{
2.- Escribir un programa que:
a. Implemente un módulo recursivo que genere y retorne una lista de números enteros
“random” en el rango 100-200. Finalizar con el número 100.
b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el
mismo orden que están almacenados.
c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de
la lista en orden inverso al que están almacenados.
d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo
valor de la lista.
e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva
verdadero si dicho valor se encuentra en la lista o falso en caso contrario.
}

program ejercicio2;
const fin=100; ini=100; fini=200;
type lista=^nodo;

	 nodo = record
		dato:integer;
		sig:lista;
	 end;

{INCISO A}
procedure agregarNum(var l:lista; num:integer);
var
	nuevo:lista;
begin
	new(nuevo); nuevo^.dato:=num; nuevo^.sig:=nil;
	if(l=nil)then
		l:=nuevo
	else begin
		nuevo^.sig:=l;
		l:=nuevo;
	end;
end;
{INCISO A}
procedure cargarLista (var l:lista);
var
	ale, aux: integer;
begin
	aux:= fini-ini;
	ale:= ini + random(aux -1);
	if(ale<>fin)then begin
		agregarNum(l, ale);
		cargarLista(l);
	end;
end;

procedure imprimirLista(l: lista);
 begin
	if (l <> nil) then begin
		writeln('Numero: ', l^.dato);
		imprimirLista(l^.sig); {paso al nodo sig}
	end;
 end;

procedure imprimirInverso(l: lista);
 begin

	if (l <> nil) then begin
		imprimirInverso(l^.sig); {Llamo hasta el último nodo, 
		llega a NIL y va volviendo al primero mientras se imprime}
		writeln('Numero: ', l^.dato);
	end;
end;

function min(a, b: integer): integer;
 begin
  if (a < b) then min:= a
  else min:= b;
 end;
 
function minimo(lis: lista): integer;
 begin
  if(lis = NIL) then minimo:= 9999 {un valor muy alto que no es MIN porque la list está vacia}
  else
    minimo:= min(lis^.dato, minimo(lis^.sig)) {le paso el dato a comparar con el siguiente de la lista}
    {compara a con b (dato con el siguiente)}
 end;

{ LO QUE YO HICE
function minimo(l: lista; min: integer):integer;
 begin
	if (l<>nil) then begin
	  if (l^.dato < min) then min:= l^.dato;
	  minimo := minimo(l^.sig, min); recursividad
	end;
	minimo:= min;
 end;
}

{
e) módulo recursivo que reciba la lista generada en a) y un valor y devuelva
verdadero si dicho valor se encuentra en la lista o falso en caso contrario.
}

function buscar (a, num: integer):boolean;
 begin
  if (a = num) then buscar:= true
  else buscar:= false;
 end;

function esta(lis:lista; num: integer): boolean;
 begin
  if (lis = NIL) then esta:= false
  else if (lis^.dato = num) then esta:= true
  else esta:= esta(lis^.sig, num);
 end;

var l:lista; num: integer;
BEGIN
	randomize;
	cargarLista(l);{a}
	writeln('Lista como se almacenaron los datos...');
	imprimirLista(l);{b}
	writeln('Lista inversa...');
	imprimirInverso(l); {c}
	writeln('Minimo valor de la lista: ', minimo(l));
	writeln('-----------');
	writeln('Ingrese un numero a buscar en su lista: '); readln(num);
	writeln('Esta el numero en la lista?: ', esta(l, num));
	
END.
