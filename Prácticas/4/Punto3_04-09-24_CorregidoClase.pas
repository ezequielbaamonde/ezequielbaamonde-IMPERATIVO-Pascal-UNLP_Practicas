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
		cant_u: integer;
		monto_total: real;
	 end;
	 
	 ventas = record
		cod_v: integer;
		codProd: integer;
		cant_u: integer;
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
		v.codProd:= random(101) + 1;
		v.cant_u:= random(601) + 1;
		v.precio_u:= random(5001) + 1000;
	end;
 end;
 
 
procedure genArbol (var a: arbol; v: ventas);
 begin
	if (a = NIL) then begin
		new(a);
		a^.dato.cod:= v.codProd;
		a^.dato.cant_u:= v.cant_u;
		a^.dato.monto_total:= v.cant_u * v.precio_u;
		a^.HI:= NIL;
		a^.HD:= NIL;
	end
	
	else 
		if (a^.dato.codPro = v.pro.cod)then begin
			a^.dato.cant_u:= a^.dato.cant_u + v.cant_u;
			a^.dato.monto_total:= a^.dato.monto_total + (v.cant_u * v.precio_u);
		end
		if(a^.dato.codPro > v.pro.cod) then 
			genArbol(a^.HI, v)
		else 
			genArbol(a^.HD, v); //Si es mayor o igual se agrega a la derecha
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
		writeln('Codigo de venta: ', a^.dato.cod_v);
		writeln('Codigo de producto: ', a^.dato.pro.cod);
		writeln('Cantidad de Unidades vendidas: ', a^.dato.pro.cantU);
		writeln('Monto total: ', a^.dato.pro.monto:1:2);
		writeln('Precio Unitario: ', a^.dato.precio_u:1:2);
		writeln('********************************************');
		enOrden(a^.HD);
	end;
 end;

 //FIN PROCEDIMIENTOS INCISO A
//----

 //----------------------------------------------
//PROCEDIMIENTOS INCISO C
procedure buscar(a: arbol; var cod: integer; var max: real):integer;
 begin
	if (a <> NIL) then begin
		buscar(a^.HI, cod, max);
		if (max < a^.dato.montoTotal) then begin
			max:= a^.dato.montoTotal;
			cod:= a^.dato.codProd;
		end
		buscar(a^.HD, cod, max);
 end;

 //FIN PROCEDIMIENTOS INCISO C
//----------------------------------------------

 //----------------------------------------------
//PROCEDIMIENTOS INCISO D _ CONTAR
function contarMenores(a: arbol; n: integer):integer;
 begin
	if (a = nil) then contarMenores:= 0
	else if (a^.dato.pro.cod < n) then begin
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
		if (a^.dato.pro.cod > x) and (a^.dato.pro.cod < y) then monto:= monto + a^.dato.pro.monto; //NO INCLUYE = A X o Y
		acumularTotal(a^.HD, x, y, monto);
	end;
 end;

 //FIN PROCEDIMIENTOS INCISO E
//----------------------------------------------

//VARIABLES GLOBALES
var a: arbol; max: real;
	x, y, num, codMax: integer; cant: real;

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
	writeln('***IMPRESION DE COD CON MAX UNIDADES VENDIDAS***')
	max:= -1; codMax:= 0;
	buscar(a, codMax, max);
	writeln('El codigo del producto con mayor cantidad de unidades vendidas es: ',codMax);	
	
	//INCISO D
	writeln('Ingrese un numero para buscar codigos menores a el: ');read(num);
	writeln('La cantidad de numeros que son menores al código ingresado es: ', contarMenores(a, num));
	
	//INCISO E
	writeln('***ACUMULACION MONTOS***');
	writeln('Ingrese un intervalo de 2 codigos de producto el cual quiera saber su monto total entre ellos: '); readln(x);readln(y);
	cant:= 0;
	acumularTotal(a, x, y, cant); writeln('El monto total entre ellos es de: $', cant:2:2);
	
END.


//CONSULTAR:
// INCISO C.

 //Corrección, mi ARBOL tiene que ser de tipo PRODUCTOS, lo corregimos en la carga y en la carga de la venta.
  //Ahora almaceno unicamente 1 cod pro, por ende, en este inciso debo recorrer todo el arbol y devolver solo el codMAX  través de un procedimiento.
