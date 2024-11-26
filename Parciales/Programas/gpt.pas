program BAAMONDE; //Ezequiel DNI 45.782.596

type
  meses = 1..12;

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
// INCISO A
procedure leerCompra(var c: compra);
begin
  writeln('Ingrese código de cliente (0 para terminar): ');
  readln(c.codCli);
  if (c.codCli <> 0) then begin
    writeln('Ingrese número de mes (1-12): ');
    readln(c.mes);
    writeln('Ingrese monto gastado: ');
    readln(c.montoGastado);
  end;
end;

procedure iniVector(var v: vectorMeses);
var
  i: meses;
begin
  for i := 1 to 12 do v[i] := 0;
end;

procedure cargarArbol(var a: arbol; c: compra);
begin
  if (a = NIL) then begin
    new(a);
    // Inicialización de datos
    a^.dato.codCli := c.codCli;
    iniVector(a^.dato.total);
    a^.dato.total[c.mes] := c.montoGastado;
    // Inicialización de hijos
    a^.HI := NIL;
    a^.HD := NIL;
  end
  else if (a^.dato.codCli > c.codCli) then 
    cargarArbol(a^.HI, c)
  else if (a^.dato.codCli < c.codCli) then 
    cargarArbol(a^.HD, c)
  else 
    a^.dato.total[c.mes] := a^.dato.total[c.mes] + c.montoGastado;  // Acumula monto gastado de cada cliente según el mes
end;

// Lectura de compra y creación estructura ARBOL
procedure crearEstructura(var a: arbol);
var
  com: compra;
begin
  leerCompra(com);
  while (com.codCli <> 0) do begin
    cargarArbol(a, com);
    leerCompra(com);
  end;
end;

//*********************************************
// INCISO B
// Recorrer vector y buscar el mes con mayor gasto
function buscarMesMax(v: vectorMeses): meses;
var
  i, aux: meses;
  cantMax: real;
begin
  cantMax := -1;
  aux := 1; // Inicializo para evitar valores indefinidos
  for i := 1 to 12 do begin
    if (cantMax < v[i]) then begin
      cantMax := v[i];
      aux := i;
    end;
  end;
  buscarMesMax := aux; // Retorno mes con mayor gasto
end;

// Recorrer árbol y buscar el mes con más gasto del cliente ingresado
procedure buscarMes(a: arbol; c: integer; var m: meses);
begin
  if (a <> nil) then begin
    if (a^.dato.codCli = c) then 
      m := buscarMesMax(a^.dato.total) // Si lo encuentra, almacena el mes con mayor gasto
    else if (a^.dato.codCli > c) then 
      buscarMes(a^.HI, c, m) // Busca por izquierda si el código es menor
    else 
      buscarMes(a^.HD, c, m); // Busca por derecha si el código es mayor
  end
  else
    writeln('Cliente no encontrado.');
end;

//*********************************************
// PROGRAMA PRINCIPAL
var
  a: arbol;
  cod: integer;
  mes: meses;

begin
  a := nil;  // Inicializo el árbol a NIL
  
  // Inciso "a"
  crearEstructura(a);
  
  // Inciso "b"
  writeln('Ingrese un código de cliente para buscar el mes con mayor gasto acumulado: '); 
  readln(cod);
  
  buscarMes(a, cod, mes);
  writeln('El mes con mayor gasto del cliente ', cod, ' es: ', mes);
end.
