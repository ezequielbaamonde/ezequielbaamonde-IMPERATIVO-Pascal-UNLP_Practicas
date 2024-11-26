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

Nota: El módulo debe retornar TRES árboles}

type 

//INICIO TIPOS DE DATOS | INCISO A --------------------------------------------------
	fecha = record
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

	ventas3=record {contiene solo codProducto y listaDeVentas}
		cod:integer;
		listaV:listaVentas;
	end;

	arbol3 = ^nodo;
	nodo3 = record 
		dato: ventas3;
		HD: arbol3;
		HI: arbol3;
	end;
//FIN TIPOS DE DATOS | INCISO A ------------------------------------------------



{PROCEDIMIENTOS}
 //-----------------------------------------------------------------------------
//INCISO A
procedure cargarVentas (var v:ventas);
 begin
    v.cod:= random (101); {50 numeros aleatorios}
    if (v.cod <> 0)then begin
		v.fechaV.dia:= 1 + random (31); {RANDOM DÍA entre 1 y 31}
		v.fechaV.mes:= 1 + random (12); {RANDOM MES entre 1 y 12}
		v.fechaV.anio:= 2024; {AÑO}
        v.cantU:= random (101); {Edad RANDOM entre 12 y 100}
        
        //NO PIDE IMPRIMIR PERO LO PUSE PARA VER SI ESTABA CARGANDO BIEN LA VENTA Y EL CORTE DEL MNISMO.
        writeln('El codigo del producto es: ', v.cod);
        writeln('La fecha de venta es: "', v.fechaV.dia, '" del mes "', v.fechaV.mes, '" del "', v.fechaV.anio, '"');
        writeln('La cantidad de unidades vendidas es: ', v.cantU);
    end;
 end;   
 
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
		else if (dato.cod <= a^.dato.cod) then agregarArbol1(a^.HI, dato)
		else agregarArbol1(a^.HD, dato) {SI ES MAYOR O IGUAL}
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
		else if (dato.cod <= a2^.dato.cod) then agregarArbol2(a2^.HI, dato)
		else agregarArbol2(a2^.HD, dato); {SI ES MAYOR O IGUAL}	
	 end;
	
	//TERCER ARBOL
	procedure agregarArbol3 (var a3: arbol3; dato: ventas);
	 var nuevaVenta: listaVentas;
	 begin
		if (a3 = NIL) then begin
			//genero árbol
			new(a3);
			a3^.dato.cod:= dato.cod; 
			//genero lista
			new (nuevaVenta); nuevaVenta^.dato:= dato; nuevaVenta^.sig:= NIL;
			//declaro valores del arbol
			a3^.dato.listaV:= nuevaVenta; //añado la lista generada al dato del arbol
			a3^.HI:= NIL;
			a3^.HD:= NIL;
		end;
			if (dato.cod < a3^.dato.cod) then agregarArbol3(a3^.HI, dato)
			else if (dato.cod >= a3^.dato.cod) then agregarArbol3(a3^.HD, dato) {SI ES MAYOR O IGUAL}	
			else begin
				new(nuevaVenta);
				nuevaVenta^.dato := dato;
				nuevaVenta^.sig := a3^.dato^.listaV^.sig;
				//aL^.dato := nuevaVenta; //enganche
			end;
	 end;
 //Programa del procedimiento incisoA
 begin
	agregarArbol1(a, dato);
	agregarArbol2(a2, dato);
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




var a, a2, a3: arbol;

begin
	randomize;
	a:= NIL;
	a2:= NIL;
	a3:= NIL;
	almacenarArbol(a, a2, a3);
end.
