{
3. Implementar un programa modularizado para una librería. Implementar módulos para:

a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados su código, la
cantidad total de unidades vendidas y el monto total. De cada venta se lee código de
venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El
ingreso de las ventas finaliza cuando se lee el código de venta -1.

b. Imprimir el contenido del árbol ordenado por código de producto.

c. Retornar el código de producto con mayor cantidad de unidades vendidas.

d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor
que se recibe como parámetro.

e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos
valores recibidos (sin incluir) como parámetros.

}

program Punto3_P4;

 //----------------------------------------------
//ARBOLES Y REGISTROS

type productos = record
		cod: integer;
		cantU: integer;
		monto_total: real;
	 end;
	 
	 ventas = record
		cod_v: integer;
		codPro: integer; //cod y cantU vendidas
		cantU: integer;
		precio_u: real;
	 end;
	 
	 arbol = ^nodo;
	 nodo = record
		dato: productos;
		HI: arbol;
		HD: arbol;
	 end;

 //----------------------------------------------
//PROCEDIMIENTOS INCISO A

procedure cargarVentas (var v: ventas); //2
 begin
	v.cod_v:= random(51) - 1;
	if (v.cod_v <> -1) then begin
		v.codPro:= random(101) + 1;
		v.cantU:= random(601) + 1;
		v.precio_u:= random(5001) + 1000;
	end;
 end;
 
 
procedure genArbol (var a: arbol; v: ventas);
 var ventas_total: real;
 begin
	if (a = NIL) then begin
		new(a);
		ventas_total:= (v.cantU * v.precio_u);
		a^.dato.cod:= v.codPro; 
		a^.dato.cantU:= v.cantU; 
		a^.dato.monto_total:= ventas_total; //variable con el monto total de la venta
		a^.HI:= NIL;
		a^.HD:= NIL;
	end
	else if (a^.dato.cod = v.codPro) then begin//sumar unidad al mismo producto y acumular un nuevo monto total
		a^.dato.cantU:= a^.dato.cantU + 1;
		a^.dato.monto_total:= a^.dato.monto_total + ventas_total
	end
	else if (a^.dato.cod > v.codPro) then genArbol(a^.HI, v) //Si es mayor se agrega a la izquierda (opuesto)
	else genArbol(a^.HD, v); //Si es menor se agrega a la derecha (opuesto)
 end;


procedure almacenarArbol (var a:arbol); //1
 var ven: ventas;
 begin
	cargarVentas(ven);
	while (ven.cod_v <> -1) do begin
		genArbol(a, ven);
		cargarVentas(ven);
	end;
 end;

 //FIN PROCEDIMIENTOS INCISO A
//-----------------------------------------------

 //----------------------------------------------
//PROCEDIMIENTOS INCISO B
procedure enOrden(a:arbol);
 begin
	if (a <> nil) then begin
		enOrden(a^.HI);
		writeln('Codigo de producto: ', a^.dato.cod);
		writeln('Cantidad de Unidades vendidas: ', a^.dato.cantU);
		writeln('Monto total: ', a^.dato.monto_total:1:2);
		writeln('Precio Unitario: ', (a^.dato.monto_total / a^.dato.cantU):1:2);
		writeln('********************************************');
		enOrden(a^.HD);
	end;
 end;

 //FIN PROCEDIMIENTOS INCISO A
//----

 //----------------------------------------------
//PROCEDIMIENTOS INCISO C
procedure buscar(a: arbol; var cod: integer; var max: real);
 begin
	if (a <> NIL) then begin
		buscar(a^.HI, cod, max);
		if (a^.dato.cantU > max) then begin
			max:= a^.dato.cantU;
			cod:= a^.dato.cod;
		end;
		buscar(a^.HD, cod, max);
 end;
end;
 //FIN PROCEDIMIENTOS INCISO C
//----------------------------------------------

 //----------------------------------------------
//PROCEDIMIENTOS INCISO D _ CONTAR
function contarMenores(a: arbol; n: integer):integer;
 begin
	if (a = nil) then contarMenores:= 0
	else if (a^.dato.cod < n) then begin
		contarMenores:= 1 + contarMenores (a^.HI, n) + contarmenores (a^.HD, n); //Contabilizo menores y busco por HI y HD
	end
	else contarMenores:= contarMenores (a^.HI, n) + contarmenores (a^.HD, n); //SINO, PASO A LA HOJA IZQ Y DER
	
 end;

 //FIN PROCEDIMIENTOS INCISO D
//----------------------------------------------

 //----------------------------------------------
//PROCEDIMIENTOS INCISO E 
procedure acumularTotal(a:arbol; x, y: integer; var monto: real);
 begin
	if (a <> nil) then begin
		acumularTotal(a^.HI, x, y, monto);
		if (a^.dato.cod > x) and (a^.dato.cod < y) then monto:= monto + a^.dato.monto_total; //NO INCLUYE = A X o Y
		acumularTotal(a^.HD, x, y, monto);
	end;
 end;

 //FIN PROCEDIMIENTOS INCISO E
//----------------------------------------------

//VARIABLES GLOBALES
var a: arbol; 
	x, y, num, codMax: integer;
	cantMax, cant: real;

//PROGR. PRINCIPAL
BEGIN
	randomize; //RANDOM
    a:= NIL;
    //INCISO A
	almacenarArbol(a);
	//INCISO B
	writeln('***IMPRESION DE ARBOL***');
	enOrden(a);
	//INCISO C
	writeln('***IMPRESION DE COD CON MAX UNIDADES VENDIDAS***');
	cantMax:= -1; codMax:= 0;
	buscar(a, codMax, cantMax);
	writeln('El codigo del producto con mayor cantidad de unidades unitarias vendidas es: ',codMax);
	writeln('********************************************');
	
	//INCISO D
	writeln('***IMPRESION DE CODIGOS MENORES A UN NUMERO SOLICITADO***');
	writeln('Ingrese un numero para buscar codigos menores a el: ');read(num);
	writeln('La cantidad de numeros que son menores al codigo ingresado es: ', contarMenores(a, num));
	writeln('********************************************');
	
	//INCISO E
	writeln('***ACUMULACION MONTOS***');
	writeln('Ingrese un intervalo de 2 codigos de producto el cual quiera saber su monto total entre ellos: '); readln(x);readln(y);
	cant:= 0;
	acumularTotal(a, x, y, cant); writeln('El monto total entre ellos es de: $', cant:2:2);
	
END.
