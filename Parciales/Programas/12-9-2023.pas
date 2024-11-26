//Parcial 12-09-23
//Módulo imperativo

{
Se lee información de las compras realizadas por los clientes a un
supermercado en el año 2022. De cada compra se lee el código del cliente,
número de mes y monto gastado. La lectura finaliza cuando se lee el cliente
con código 0.

	a) Realizar un módulo que lea la información de las compras y retorne una
	estructura de datos eficiente para la busqueda "por código de cliente". 
	Para cada cliente, esta estructura debe acumular el monto total gastado para
	cada mes del año 2022. Se sugiere utilizar el módulo leerCompra().
	
	b) Realizar un modulo que reciba la estructura generada en a) y un cliente, y
	retorne el mes con mayor gasto de dicho cliente.
	
	c) Realizar un modulo que reciba la estructura generada en a) y un número de mes, y
	retorne la cantidad de clientes que no gastaron nada en dicho mes.
	
NOTA: Implementar el prorgama principal, que invoque a los incisos a, b y c 
}


program BAAMONDE; //Ezequiel DNI 45.782.596

type meses = 1..12; 

	compra = record
		codCli: integer;
		mes: integer;
		montoGastado: real;
	 end;
	 
	vectorMeses = array [meses] of real; //acumula por mes el total gastado de cada cliente
	
	cliente = record
		codCli: integer;
		total: vectorMeses;
	end;
	 
	arbol = ^nodo;
	nodo = record
		dato: cliente;
		HI: arbol;
		HD: arbol;
	end;



//*********************************************
//INCISO A
procedure leerCompra(var c: compra);
 begin
	c.codCli:= random(10);
	if(c.codCli <> 0) then begin
		c.mes:= random(12) + 1;
		c.montoGastado:= random(200000);
	end;
 end;


procedure iniVector(var v:vectorMeses);
 var i: meses;
 begin
	for i:=1 to 12 do v[i]:= 0;
 end;
 
 
procedure cargarArbol(var a: arbol; c: compra);
 begin
	if (a = NIL) then begin
		new(a);
		//Almacenamiento de codigo cliente
		a^.dato.codCli:= c.codCli;
		//inicializo vector de meses 
		iniVector(a^.dato.total);
		//Almacenamiento de montos
		a^.dato.total[c.mes]:= a^.dato.total[c.mes] + c.montoGastado;
		//SIG HIJOS
		a^.HI:= NIL;
		a^.HD:= NIL;
	end
	else if (a^.dato.codCli > c.codCli) then cargarArbol(a^.HI, c)
	else if (a^.dato.codCli < c.codCli) then cargarArbol(a^.HD, c)
	else a^.dato.total[c.mes]:= a^.dato.total[c.mes] + c.montoGastado;  //acumulo monto gastado de cada cliente segun el mes
 end;

//Lectura compra y creación estructura ARBOL
procedure crearEstructura (var a: arbol);
 var com: compra;
 begin
	leerCompra(com);
	while (com.codCli <> 0) do begin
		cargarArbol(a, com);
		leerCompra(com);
	end;
 end;

//*********************************************
//INCISO B

//Recorro vector y busco el max, retorno el mes
function buscarMesMax(v: vectorMeses): meses;
 var i, aux: meses; cantMax: real;
 begin
	cantMax:= -1;
	for i:= 1 to 12 do begin
		if (cantMax < v[i]) then begin
			cantMax:= v[i];
			aux:= i;
		end;
	end;
	buscarMesMax:= aux; //retorno mes max
 end;

//Recorro arbol y busco el mes con mas gasto del cliente ingresado
procedure buscarMes(a: arbol; c: integer; var m:meses);
 begin
	if (a <> nil) then begin
		if (a^.dato.codCli = c) then m:= buscarMesMax(a^.dato.total) //si lo encuenta,  almacena el mes con mayor gasto del cliente en el parametro "m"
		else if (a^.dato.codCli > c)then buscarMes(a^.HI, c, m) //busco por hoja izquierda al cod cliente ingresado
		else  buscarMes(a^.HD, c, m); //sino, busco el cod cliente ingresado por hoja derecha
	end;
 end;



//*********************************************
//INCISO C

procedure sinGasto(a:arbol; m:meses; var cant:integer);
 var i: meses; aux: real;
 begin
	if (a<>nil) then begin
		for i:= 1 to m do aux:= a^.dato.total[i];
		if (aux = 0) then cant:= cant + 1; 
		sinGasto(a^.HI, m, cant);
		sinGasto(a^.HD, m, cant);
	end
 end;




//*********************************************
//**IMPRESIÓN ARBOL**
procedure imprimirArbol(a:arbol);
 var i: integer;
 begin
	if (a<>nil) then begin
		imprimirArbol(a^.HI);
		writeln('Codigo cliente: ', a^.dato.codCli);	
		for i:=1  to 12 do writeln('Gastos MES ', i, ': ', a^.dato.total[i]:1:2);
		writeln('---------------------');
		imprimirArbol(a^.HD);
	end;
 end;




//*********************************************
//PROG. PRINCIPAL
var a: arbol; 
	cod: integer; 
	mes: meses;
	cantClientes: integer; //sin gastar

begin
	randomize;
	//Inciso "a"
	a:=NIL;
	crearEstructura(a);
	
	//***impresión del arbol -guía-***
	imprimirArbol(a);
	
	//Inciso "b"
	writeln('Ingrese un codigo de cliente para buscar el MES con mayor GASTO acumulado: '); read(cod);
	buscarMes(a, cod, mes);
	writeln('-----------------------------------------');
	writeln('Mayor MES con GASTO del cliente ', cod,': ', mes);
	
	//Inciso "c"
	writeln('-----------------------------------------');
	cantClientes:= 0;
	writeln('Ingrese un numero de MES para evaluar cuantos CLIENTES no gastaron nada en el mismo: '); read(mes); //sobreescribo mes
	sinGasto(a, mes, cantClientes); //Módulo inciso C
	writeln('La cantidad de CLIENTES SIN GASTAR en ese MES es de: ', cantClientes, ' clientes.');
end.
