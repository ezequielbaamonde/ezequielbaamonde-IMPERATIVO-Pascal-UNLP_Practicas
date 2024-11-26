{
3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción,
2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje
promedio otorgado por las críticas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
TALLER DE PROGRAMACIÓN – Módulo Imperativo 2024

a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
código de la película -1.

b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
obtenido entre todas las críticas, a partir de la estructura generada en a)..

c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
métodos vistos en la teoría.

d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
del vector obtenido en el punto c).

EL DE NO LO HICE
* 
}

program Netflix;

type rango_generos = 1..8; {dimF}
	 peliculas = record
		codPel: integer;
		codGen: rango_generos;
		punt: real;
	end;

	lista = ^nodo;
	nodo = record
		dato: peliculas;
		sig: lista;
	end;
	
	{REGISTROS}
	grupo = record
		pri, ult: lista;
	end;
	
	 inciso_b_c = record
		codPel: integer;
		punt: real;
	end;
	
	
	vector = array[rango_generos] of grupo; {vector de tipo grupos}
	vectorProm = array [rango_generos] of inciso_b_c; {vector de tipo integer que almacena el codigo de la pelicula con mayor puntaje por genero}
	
procedure leerDato(var dato:peliculas);
 begin
	writeln('Ingrese un codigo de pelicula: ');
	readln(dato.codPel);
	if(dato.codPel <> -1) then begin
		writeln('Ingrese un codigo de genero: ');readln(dato.codGen);
		writeln('Ingrese un puntaje de la pelicula: ');readln(dato.punt);
	end;
 end;

procedure inicializarV(var v: vector);
 var i: rango_generos;
 begin
	for i:= 1 to 8 do begin;
		v[i].pri:=NIL;
		v[i].ult:= NIL;
	end;
 end;

{INCISO A; POR ORDEN DE LLEGADA}
procedure agAtras(var pri, ult: lista; dato: peliculas);
 var nue: lista;
 begin
	new (nue);
	nue^.dato:= dato;
	nue^.sig:= nil;
	{Si la lista está vacia}
	if (pri = nil) then
		pri:= nue
	else ult^.sig:= nue; {sino}
	ult:= nue;
 end;

{INCISO A; Carga el vector AGRUPADAMENTE}
procedure cargarVector(var vec:vector);
 var d: peliculas;
 begin
	{pri, ult:= NIL;}
	leerDato(d);
	while (d.codPel <> -1) do begin
		agAtras(vec[d.codGen].pri, vec[d.codGen].ult, d); {Le manda la posición del vector como parámetro, cada posición va a tener 
		su propia lista y su propio pri y ult. Entonces cada vez que se va ingresando una película, se va a ir guardando en el ult 
		de esa lista (excepto cuando sea la primera, ahí se guardaría en el pri)}
		leerDato(d);
	end;
 end;

{Retorna el código y puntaje máximo de la pelicula por genero}
procedure calcularMax(lis: lista; var vec:inciso_b_c);
 var puntMax: real; codMax:integer;
 begin
	puntMax:=-1;
	while (lis <> nil) do begin
		if (lis^.dato.punt > puntMax) then begin
			puntMax:= lis^.dato.punt; 
			codMax:= lis^.dato.codPel;
		end;
		lis:= lis^.sig;
	end;
	vec.codPel:= codMax;
	vec.punt:= puntMax;
 end;

{Obtengo el maximo copd y puntaje. Retorno los datos en un vector pro de tipo inciso_b_c}
procedure obtenerMax(vec:vector; var pro: vectorProm);
 var i: rango_generos;
 begin
	for i:= 1 to 8 do
		{pro[i]:= calcularMax(vec[i].pri); almaceno en la pos I del vector "pro" el codMax y el puntMax que me devuelva la func.
											Además, le paso el vector de grupos apuntando al primer nodo de la lista para que la recorra}
 
		calcularMax(vec[i].pri, pro[i]);
 end;


{INSERCIÓN}
Procedure insercion ( var v: vectorProm); {No utiliza dimensión lógica}
 Var i, j: rango_generos; actual: inciso_b_c;	
		
 begin
  for i:= 2 to 8 do begin 
     actual:= v[i];
     j:= i-1; 
     while (j > 0) and (v[j].punt > actual.punt) do {evaluo por puntaje}
       begin
         v[j+1]:= v[j];
         j:= j-1;                
       end;  
     v[j+1]:= actual; 
  end;
 end;

{
PROGRAMA PRINCIPAL
}
var v: vector; prom: vectorProm;

begin
	inicializarV(v);
	cargarVector(v);
	obtenerMax(v, prom);
	insercion(prom);
	
end.
			
			
			
			
			
			
			
		
