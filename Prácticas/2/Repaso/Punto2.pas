{Implementar un programa que invoque a los siguientes módulos.
	a. Un módulo recursivo que retorne un vector de a lo sumo 15 números enteros “random”
	    mayores a 10 y menores a 155 (incluidos ambos). La carga finaliza con el valor 20.
	    
	b. Un módulo no recursivo que reciba el vector generado en a) e imprima el contenido del
		vector.
		
	c. Un módulo recursivo que reciba el vector generado en a) e imprima el contenido del vector.
	
	d. Un módulo recursivo que reciba el vector generado en a) y devuelva la suma de los valores
		pares contenidos en el vector.
		
	e. Un módulo recursivo que reciba el vector generado en a) y devuelva el máximo valor del vector.
	
	f. Un módulo recursivo que reciba el vector generado en a) y un valor y devuelva verdadero si
		dicho valor se encuentra en el vector o falso en caso contrario.
		
	g. Un módulo que reciba el vector generado en a) e imprima, para cada número contenido en
		el vector, sus dígitos en el orden en que aparecen en el número. Debe implementarse un
		módulo recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 142, se
		debe imprimir 1 4 2.}


program recursividad;
const dimF = 15;
type
	vectorRandom = array [1..15] of integer;
	
procedure generarVector(var v: vectorRandom; var dimL: integer);
 var valor, aux: integer;
 begin
	aux:= 155-10; //Max 155 y Min 10
	valor:= 10 + random(aux+1); //min + random(145+1)
	if (valor<>20) and (dimL<dimF) then begin
		dimL:= dimL+1;
		v[dimL]:= valor;
		generarVector(v, dimL);
	end;
 end;

procedure imprimirVector(v:vectorRandom; dimL: integer);
 var i: integer;
 begin
	for i:=1 to dimL do writeln('Valor ', i, ': ', v[i]);
 end;

procedure imprimirVectorRecursivo(v:vectorRandom; dimL: integer);
 begin
	if (dimL>0) then begin
		imprimirVectorRecursivo(v, dimL-1);
	    writeln('Valor ', dimL, ': ', v[dimL]);
	end;
 end;

function sumarValores(v: vectorRandom; pos, dimL: integer): integer;
 begin
	if (pos<=dimL) then begin
		if ((v[pos] mod 2) = 0) then sumarValores:= v[pos] + sumarValores(v, pos+1, dimL) //si es par suma el valor + el sig par
		else sumarValores:= sumarValores(v, pos+1, dimL); //sino, evalua el siguiente a ver si debe sumar par o no.
	end;
 end;



function obtenerMax(v: vectorRandom; dimL: integer):integer;
 begin
	if (dimL>0) then begin
		if (dimL=1) then obtenerMax:= v[dimL] //almaceno primer elemento (o único) en la función para asi compararlo.
		else
		 begin
			obtenerMax:= obtenerMax(v, dimL-1); //si no es dimL=1, llamo a la función hasta llegar allí.
			if(v[dimL] > obtenerMax) then obtenerMax:= v[dimL]; {una vez obtenerMax sea = v[1], lo comparo en
			cada posición mientras se va liberando memoria}
		 end;
	end;
 end;

function buscar(v: vectorRandom; dimL, valor: integer):boolean;
 begin
	if (dimL>0) then begin
		if (v[dimL] = valor) then
			buscar:= true
		else
			buscar:= buscar(v, dimL-1, valor);
	end
	else buscar:= false; //dimL=0, ya evaluo todas las pos y no hay valor
 end;


{este incisio lo copie de github MatiasGuayna}
procedure descomponerNumero(var dig: integer; var num: integer);
begin
	dig:= num mod 10; //queda digito en el resto
	num:= num div 10; //numeros restantes en cociente
end;


procedure impDigitos(num: integer);
var
	dig: integer;
begin
	if(num <> 0) then
		begin
			descomponerNumero(dig, num);
			impDigitos(num);
			write(' ', dig);
		end;
end;


procedure ImprimirDigitos (v: vectorRandom; dimL: integer);
begin    
    if(dimL>0) then
        begin
            ImprimirDigitos(v, dimL-1);
            writeln();
            write('Numero: ', v[dimL], ' -> ');
            impDigitos(v[dimL]);  
        end;   
end;  

var vec: vectorRandom;
    dimLogica: integer;
begin
 randomize;
 dimLogica:= 0;
 generarVector(vec, dimLogica);
 writeln('NO RECURSIVO');
 imprimirVector(vec, dimLogica);
 writeln('');
 writeln('RECURSIVO');
 imprimirVectorRecursivo(vec, dimLogica);
 writeln('');
 writeln('SUMA RECURSIVA');
 writeln('Total suma de pares: ', sumarValores(vec, 1, dimLogica));
 writeln('');
 writeln('MAXIMO RECURSIVO');
 writeln('Valor max del vector: ', obtenerMax(vec, dimLogica));
 writeln('');
 writeln('BUSCAR RECURSIVO');
 writeln('Esta: ', buscar(vec, dimLogica, 115));
 writeln('');
 writeln('DIGITOS RECURSIVO');
 ImprimirDigitos(vec, dimLogica);
end.

