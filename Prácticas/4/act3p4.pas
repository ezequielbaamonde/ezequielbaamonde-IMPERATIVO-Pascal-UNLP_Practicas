program act3p4;
type
	producto=record
		cod:integer;
		canTotal:integer;
		montoTot:real;
	end;

	venta= record
		codVenta:integer;
		codProd:integer;
		cantUnidades:integer;
		precio:real;
	end;

	arbol=^nodo;
	nodo=record
		dato:producto;
		hi:arbol;
		hd:arbol;
	end;
procedure agregarHoja (var a:arbol; v:venta);
begin
	if a=nil then begin
		new(a);
		a^.dato.cod:=v.codProd;
		a^.dato.canTotal:=v.cantUnidades;
		a^.dato.montoTot:=v.cantUnidades*v.precio;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else if a^.dato.cod=v.codProd then begin
		a^.dato.canTotal:=v.cantUnidades+a^.dato.canTotal;
		a^.dato.montoTot:=(v.cantUnidades*v.precio)+a^.dato.montoTot;
	end
	else if a^.dato.cod<v.codProd then
		agregarHoja(a^.hd,v)
	else 
		agregarHoja(a^.hi,v);
end;

procedure cargarArbol(var a:arbol);
	 procedure leer ( var v:venta);
		begin
			v.codVenta:=random(10)-1;
			if v.codVenta<>-1 then begin
				v.codProd:=random(10);
				v.cantUnidades:=random(5)+1;
				v.precio:=random(20);
			end;
		end;
var ve:venta;
begin
	randomize;
	leer(ve);
	while ve.codVenta<>-1 do begin
		agregarHoja(a,ve);
		leer(ve);
	end;
end;

procedure imprimir (a:arbol);
begin
	if a<>nil then begin
	imprimir(a^.hi);
	writeln('codigo de producto ',a^.dato.cod, ' cantidad ', a^.dato.canTotal,' precio total $',a^.dato.montoTot:2:2);
	imprimir(a^.hd);
	end;
end;

procedure maxCod(a:arbol; var cod,cant:integer ); 
begin
	if a<>nil then begin
		if cant < a^.dato.canTotal then begin
			cod:=a^.dato.cod;
			cant:=a^.dato.canTotal
		end;
		maxCod(a^.hi,cod,cant);
		maxCod(a^.hd,cod,cant);
		
	end;
end;

function contar(a:arbol;num:integer):integer;
	begin
		if a=nil then
			contar:=0
		else if a^.dato.cod <= num then
			contar:=contar(a^.hi,num)+contar(a^.hd,num)+1
		else 
			contar:=contar(a^.hi,num)+ contar(a^.hd,num);
		
	end;

var a:arbol; cod,cant,num,aux:integer;
begin
	a:=nil; cant:=0; 
	cargarArbol(a);
	imprimir(a);
	maxCod(a,cod,cant);
	writeln ('el codigo con mas ventas es ', cod, ' con ',cant, ' unidades vendidas');
	cant:=0;
	write('ingresar un numero entre 0-10 ');readln(num);
	aux:=contar(a,num);
	writeln('hay ', aux, ' codigos mas chicos que ', num);
end.
