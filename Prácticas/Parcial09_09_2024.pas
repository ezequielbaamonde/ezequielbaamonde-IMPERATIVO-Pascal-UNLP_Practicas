program parcial_09092024;

type
	sub_dias = 1..30;
	envio = record
		codCli: integer;
		dia: sub_dias;
		cp: integer;
		peso: real
	end;
	
	regLista = record
		codCli: integer;
		dia: sub_dias;
		peso: real;
	end;
	
	listaEnvios = ^nodoLis;
	nodoLis = record
		dato: regLista;
		sig: listaEnvios;
	end;
	
	arbol = ^nodoCP;
	nodoCP = record
		cp: integer;
		lista: listaEnvios;
		HI: arbol;
		HD: arbol;
	end;


procedure leerEnvio(var e: envio);
 begin
	e.codCli:= Random(100);
	if (e.codCli <> 0) then begin
		e.cp:= Random(5);
		e.dia:= 1 + random(30);
		e.peso:= Random(20000)/(Random(10)+1);
	end;
 end;

procedure agAdelante(var lis: listaEnvios; reg: regLista);
 var nue: listaEnvios;
 begin
	new (nue);
	nue^.dato:= reg;
	nue^.sig:= lis;
	lis:= nue;
 end;

procedure cargarArbol(var a: arbol; cp: integer; r: regLista);
 begin
	if (a = NIL) then begin
		new(a);
		a^.cp:= cp;
		a^.lista:= NIL;
		a^.HI:= NIL;
		a^.HD:= NIL;
		agAdelante(a^.lista, r);
	end
	else
	 begin
		if (cp = a^.cp) then begin
			agAdelante(a^.lista, r)
	    end
	    else
	     begin
			if (a^.cp > cp) then begin
				cargarArbol(a^.HI, cp, r);
			end
			else cargarArbol(a^.HD, cp, r);
	     end;
	 end;
 end;

procedure convertir(var r: regLista; e: envio);
 begin
	r.codCli:= e.codCli;
	r.dia:=e.dia;
	r.peso:=e.peso;
 end;

procedure generarArbol(var a: arbol);
 var env: envio; reg: regLista;
 begin
	leerEnvio(env);
	convertir(reg, env);
	while (env.codCli <> 0) do begin
		cargarArbol(a, env.cp, reg);
		leerEnvio(env);
		convertir(reg, env)
	end;
 
 end;

procedure recorrerArbol(a: arbol);
 begin
	if (a<>NIL) then begin	
		writeln('CP: ', a^.cp);
		recorrerArbol(a^.HI);
		recorrerArbol(a^.HI);
	end;
 end;


var abb1: arbol;
begin
 randomize;
 //a.
 abb1:= NIL;
 generarArbol(abb1);
 recorrerArbol(abb1);
end.
