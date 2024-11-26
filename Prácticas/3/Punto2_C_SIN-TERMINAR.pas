program Punto2;
{Escribir un programa que:
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

Nota: El módulo debe retornar TRES árboles

b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad
total de productos vendidos en la fecha recibida.

c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto
con mayor cantidad total de unidades vendidas.




}

//INICIO TIPOS DE DATOS | INCISO A --------------------------------------------------
type fecha = record
		 dia: integer;
		 mes: integer;
		 anio: integer;
	end;
	//i
	ventas = record
		cod: integer;
		fechaV: fecha;
		cantU: integer;
	end;
	
	//ii
	ventas2 = record
		cod: integer;
		cantU: integer;
	end;
	
	{árbol 1 | i}
	arbol = ^nodo;
	nodo = record
		dato: ventas;
		HD: arbol;
		HI: arbol;
	end;
	{árbol 2 | ii}
	arbol2 = ^nodo;
	nodo2 = record
		dato: ventas2; {contiene solo cod y cantU}
		HD: arbol2;
		HI: arbol2;
	end;
	
	{arbol 3}
	listaVentas = ^nodoListas;
	nodoListas = record
		dato: ventas;
		sig: listaVentas;
	end;

	ventas3 = record {contiene solo codProducto y listaDeVentas}
		cod: integer;
		listaV: listaVentas;
	end;

	arbol3 = ^nodo3;
	nodo3 = record 
		dato: ventas3;
		HD: arbol3;
		HI: arbol3;
	end;
//FIN TIPOS DE DATOS | INCISO A ------------------------------------------------



{PROCEDIMIENTOS}
 //-----------------------------------------------------------------------------

procedure cargarVentas (var v:ventas);
 begin
    v.cod:= random (101); {50 numeros aleatorios}
    if (v.cod <> 0)then begin
		v.fechaV.dia:= 1 + random (31); {RANDOM DÍA entre 1 y 31}
		v.fechaV.mes:= 1 + random (12); {RANDOM MES entre 1 y 12}
		v.fechaV.anio:= 2024; {AÑO}
        v.cantU:= random (101); {cantidad de unidades enidas RANDOM entre 12 y 100}
        
        //NO PIDE IMPRIMIR PERO LO PUSE PARA VER SI ESTABA CARGANDO BIEN LA VENTA Y EL CORTE DEL MNISMO.
        writeln('El codigo del producto es: ', v.cod);
        writeln('La fecha de venta es: "', v.fechaV.dia, '" del mes "', v.fechaV.mes, '" del "', v.fechaV.anio, '"');
        writeln('La cantidad de unidades vendidas es: ', v.cantU);
    end;
 end;   

//INCISO A
procedure incisoA(var a: arbol; var a2: arbol2; var a3: arbol3; dato: ventas);

	//PRIMER ARBOL
 	procedure agregarArbol1(var a: arbol; dato:ventas);
	 begin	
		if (a = NIL) then begin
			new(a);
			a^.dato:= dato;
			a^.HI:= NIL;
			a^.HD:= NIL;
		end
		else if (dato.cod < a^.dato.cod) then agregarArbol1(a^.HI, dato)
		else agregarArbol1(a^.HD, dato); {SI ES MAYOR O IGUAL}
	 end;
	 
	{\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////////////////}
	
	//SEGUNDO ARBOL
	procedure agregarArbol2 (a2: arbol2; dato: ventas);
	 begin
		if (a2 = NIL) then begin
			new(a2);
			a2^.dato.cod:= dato.cod; a2^.dato.cantU:= dato.cantU;
			a2^.HI:= NIL;
			a2^.HD:= NIL;
		end
		else if (dato.cod < a2^.dato.cod) then agregarArbol2(a2^.HI, dato)
		else agregarArbol2(a2^.HD, dato); {SI ES MAYOR O IGUAL}	
	 end;
	 
	{\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////////////////}
	//PROCEDIMIENTO AGREGAR ADELANTE EN UNA LISTA
	procedure agAdelante(var a3: listaVentas; dato: ventas);
	 var nue: listaVentas;
	 begin
		new (nue); nue^.dato:= dato; nue^.sig:= NIL;
		if (a3 = NIL) then a3 := nue
		else begin
			nue^.sig:= a3;
			a3:= nue;
		end;
	 end;
	
	{\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////////////////}
	//TERCER ARBOL
	procedure agregarArbol3 (var a3: arbol3; dato: ventas);
	 begin
		if (a3 = NIL) then begin
			//genero árbol
			new(a3);
			a3^.dato.cod:= dato.cod; 
			//genero lista y agrego adelante
			agAdelante(a3^.dato.listaV, dato);
			//declaro valores de los hijos del arbol
			a3^.HI:= NIL;
			a3^.HD:= NIL;
		end
		else if (dato.cod < a3^.dato.cod) then agregarArbol3(a3^.HI, dato)
		else if (dato.cod > a3^.dato.cod )then agregarArbol3(a3^.HD, dato)
		else  agAdelante(a3^.dato.listaV, dato){SI ES IGUAL}	
		
	 end;
 //Programa del procedimiento incisoA
 begin
	agregarArbol1(a, dato);
	agregarArbol2(a2, dato); //Almaceno y genero un arbol que contenga el cod del producto y su cant unidades vendidas
	agregarArbol3(a3, dato);
 end;

//PROCEDIMIENTO DONDE CARGAMOS VENTAS Y GENERAMOS ARBOLES
procedure almacenarArbol(var a: arbol; var a2: arbol2; var a3: arbol3);
 var venta: ventas;
 begin
	cargarVentas(venta);
		while (venta.cod <> 0) do begin
			incisoA(a, a2, a3, venta);
			cargarVentas(venta);
		end;
 end;
 
 //FIN INCISO A
//-----------------------------------------------------------------------------

 //-----------------------------------------------------------------------------
//INCISO B


//RECORRER ARBOL
function buscarFecha(a: arbol; f: fecha): integer;
 begin
	if (a = NIL) then buscarFecha:= 0 //No hay productos vendidos
	else if (a^.dato.fechaV.dia = f.dia) and (a^.dato.fechaV.mes = f.mes) and (a^.dato.fechaV.anio = f.anio) then begin
		buscarFecha:= a^.dato.cantU + buscarFecha(a^.HD, f) + buscarFecha(a^.HD, f) //sumo la cantU vendidas y corroboró sus hijos 
		//para verificar si hay mas de una fecha igual
	end
	else buscarFecha:= buscarFecha(a^.hi, f) + buscarFecha(a^.hd, f); //llamo con los otro hijo
 end;


procedure incisoB(a: arbol);
 var fec: fecha;
 begin
	writeln('Ingrese una fecha en la que quiera ver la cantidad de productos vendidos (dd/mm/aaaa): '); 
	writeln('Dia: ');read(fec.dia);writeln('Mes: ');read(fec.mes);writeln('Anio: ');read(fec.anio);
	writeln ('La cantidad de productos vendidos en esa fecha es de: ', buscarFecha(a, fec));
 end;
 //FIN INCISO B
//-----------------------------------------------------------------------------

 //-----------------------------------------------------------------------------
//INCISO C: Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto con mayor cantidad total de unidades vendidas.

function obtenerMax(a2: arbol; cant: integer):integer;
 var codMax: integer;
 begin
	if (a2 = NIL) then obtenerMax:= 0 //No hay productos vendidos
	else if (a2^.dato.cantU > cant) then begin 
		cant:= a2^.dato.cantU; codMax:= a2^.dato.cod;
	end
	else obtenerMax:= obtenerMax(a2^.hi, cant) + obtenerMax(a2^.hd, cant); //recorro el arbol buscando algún código con mayor ventas que el primer nod
	
	obtenerMax:= codMax;
 end;


procedure incisoC(a2: arbol2);
 var cant: integer;
 begin
	cant:= -1;
	writeln('El codigo del producto con mayor cantidad total de unidades vendidas es: ', obtenerMax(a2, cant));
 end;



//FIN INCISO C
//-----------------------------------------------------------------------------

var a: arbol; a2: arbol2; a3:arbol3;
begin
	randomize;
	a:= NIL;
	a2:= NIL;
	a3:= NIL;
	almacenarArbol(a, a2, a3);
	writeln('****Inciso B****');
	incisoB(a);
	writeln('****Inciso C****');
	incisoC(a2);
end.
