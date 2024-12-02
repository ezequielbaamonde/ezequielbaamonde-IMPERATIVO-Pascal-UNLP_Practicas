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
		{e.cp:= 1000 + (random(3000) + 1);}
		e.cp:= random(10);
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
		recorrerArbol(a^.HI);
		writeln('CP: ', a^.cp);
		recorrerArbol(a^.HD);
	end;
 end;

procedure retEnv(a: arbol; var lis: listaEnvios; c: integer);
 begin
	if (a <> NIL) then begin
		if (a^.cp = c) then begin
			lis:= a^.lista;
		end;
		retEnv(a^.HI, lis, c);
		retEnv(a^.HD, lis, c);
	end;	
 end;

procedure recorrerLista(lis: listaEnvios);
 begin
	while(lis <> NIL) do begin
		writeln('Cod Cliente ', lis^.dato.codCli, ', peso: ', lis^.dato.peso:1:2);
		lis:= lis^.sig;
	end;
 end;

procedure doscodigos(lis: listaEnvios; var max, min: real; var cMax, cMin: integer);
 begin
	if (lis <> NIl) then begin
		if (lis^.dato.peso > max) then begin
			max:= lis^.dato.peso;
			cMax:= lis^.dato.codCli
		end
		else
		 begin
			if (lis^.dato.peso < min) then begin
				min:= lis^.dato.peso;
				cMin:= lis^.dato.codCli;
			end;
		 end;
		
		doscodigos(lis^.sig, max, min, cMax, cMin);
	end;
 end;

var abb1: arbol; max, min: real; cp, cMax, cMin: integer; lisEnv: listaEnvios;
begin
 randomize;
 //a.
 abb1:= NIL;
 generarArbol(abb1);
 writeln('*Mostrando ARBOL....*');
 recorrerArbol(abb1);
 writeln();
 //b.
 cp:= 2;
 lisEnv:= NIL;
 retEnv(abb1, lisEnv, cp);
 writeln('*Mostrando INCISO B....*');
 recorrerLista(lisEnv);
 writeln();
 //c.
 max:= -1; min:= 9999;
 cMax:= 0; cMin:= 0;
 doscodigos(lisEnv, max, min, cMax, cMin);
 writeln('*Mostrando INCISO C...*');
 writeln('Codigo del cliente con mayor peso: ', cMax);
 writeln('Codigo del cliente con menor peso: ', cMin);
end.
