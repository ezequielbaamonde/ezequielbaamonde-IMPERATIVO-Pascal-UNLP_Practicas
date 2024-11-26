{Netflix ha publicado la lista de películas que estarán disponibles durante el mes de 
diciembre de 2022. De cada película se conoce: código de película, código de género
(1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental 
y 8: terror) y puntaje promedio otorgado por las críticas.
 Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:

	- a. Lea los datos de películas, los almacene por orden de llegada y |agrupados por código
		 de género|, y retorne en una estructura de datos adecuada. La lectura finaliza cuando 
		 se lee el código de la película -1.
	- b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
		 obtenido entre todas las críticas, a partir de la estructura generada en a)..
	- c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
		 métodos vistos en la teoría.
	- d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
		 del vector obtenido en el punto c).}
		 
program Netflix;

type
	subgeneros = 1..8;
	
	pelicula = record
		cod: integer;
		gen: subgeneros;
		punt: real;
	end;
	
	//Agrupados por cod de genero
	lista = ^nodo;
	nodo = record
		dato: pelicula;
		sig: lista;
	end;
	
	//utilizado por el vecGeneros para tener 2 punteros por genero.
	grupo = record
		pri: lista;
		ult: lista;
	end;
	
	puntajes = record
		cod: integer;
		puntaje: real;
	end;
	
	//Vector de peliculas por generos
	vecGeneros = array [subgeneros] of grupo;
	//Vector de puntajes, contiene codigos de peliculas por género y su puntaje.
	vecPuntajes = array [subgeneros] of puntajes;
	
procedure iniVector(var v: vecGeneros);
 var i: subgeneros;
 begin
	for i:=1 to 8 do begin
		v[i].pri:= NIL;
		v[i].ult:= NIL;
	end;
 end;

procedure leerPelicula(var p: pelicula);
 begin
	writeln('Ingrese un codigo de pelicula:');
	readln(p.cod);
	if (p.cod <> -1) then begin
		writeln('Ingrese un codigo de genero:');
		readln(p.gen);
		writeln('Ingrese un puntaje:');
		readln(p.punt);
	end;
 end;
 
procedure insertarAlFinal(var pri, ult: lista; p: pelicula);
 var nue: lista;
 begin
	new (nue);
	nue^.dato:= p;
	nue^.sig:= NIL;
	//Si pri no tiene datos, nue es ahora pri.
	if(pri = NIL) then pri:= nue
	//sino, se le asignara al ultimo.
	else ult^.sig:= nue;
	ult:= nue;
 end;
 

procedure cargarVector(var v:vecGeneros);
 var peli: pelicula;
 begin
	leerPelicula(peli);
	while (peli.cod <> -1) do begin
		insertarAlFinal(v[peli.gen].pri, v[peli.gen].ult, peli);
		leerPelicula(peli);
	end;
 end;
 
procedure recorrer(l: lista; var m: real; var c: integer);
 begin
	while (l <> nil) do begin
		if (l^.dato.punt>m) then begin
			m:= l^.dato.punt;
			c:= l^.dato.cod;
		end;
		l:= l^.sig;
	end;
 end;
 
procedure cargarMaxs(vec: vecGeneros; var vec2: vecPuntajes);
 var i, codMax: integer; max: real;
 begin
	for i:= 1 to 8 do begin
		max:= -1;
		codMax:= -1;
		recorrer(vec[i].pri, max, codMax); //recorre lista del genero i obteniendo el codigo y puntaje max
		vec2[i].cod:= codMax;
		vec2[i].puntaje:= max;
	end;
 end;
 
procedure insercion(var v2: vecPuntajes);
 var i, j: integer; actual: puntajes;
 begin
	for i:=2 to 8 do begin
		actual:= v2[i];
		j:= i-1;
		while (j>0) and (v2[j].puntaje > actual.puntaje) do begin
			v2[j+1]:= v2[j];
			j:= j-1;
		end;
		v2[j+1]:= actual;
    end;
 end; 
 
var vector: vecGeneros; vector2: vecPuntajes; 
	{i: subgeneros;}

begin
	iniVector(vector);
	cargarVector(vector);
	cargarMaxs(vector, vector2);
	insercion(vector2);
	writeln('Codigo de pelicula con menor puntaje: ', vector2[1].cod);
	writeln('Codigo de pelicula con mayor puntaje: ', vector2[8].cod);

end.
 
 
