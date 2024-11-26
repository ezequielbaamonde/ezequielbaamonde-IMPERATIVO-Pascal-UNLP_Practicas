program vectores;
const dimF = 50;
type
 vector = array [1..dimF] of integer;

//Inicializar vector
procedure iniVector(var v: vector);
 var i: integer;
 begin
	for i:=1 to dimF do
		v[i]:= 0;
 end;
 
//Cargar vector
procedure cargarVector(var v: vector; min, max: integer);
 var ale, aux, dimL: integer;
 begin
    dimL:=1;
    aux:= (max-min);
    ale:= min + random(aux+1);
	while (ale<>0) and (dimL<51) do begin //mientras aleatorio sea distinto de cero y dimL sea hasta 50
	    v[dimL]:= ale;
	    dimL:= dimL + 1;
		ale:= min + random(aux+1);
    end;
 end;

//Imprimir vector
procedure imprimirVector(v: vector);
 var i: integer;
 begin
	for i:= 1 to dimF do
		writeln('Posicion ', i, ', numero: ', v[i]);
 end;
 
//Imprimir vector inverso
procedure imprimirVectorInverso(v: vector);
 var i: integer;
 begin
	for i:= dimF downto 1 do
		writeln('Posicion ', i, ', numero: ', v[i]);
 end;
 
//Variables prog principal
var
 vec: vector;
 maximo, minimo: integer;
begin
 randomize;
 iniVector(vec);
 writeln('Ingrese un minimo como intervalo de numeros: ');
 readln(minimo);
 writeln('Ingrese un maximo como intervalo de numeros: ');
 readln(maximo);
 cargarVector(vec, minimo, maximo);
 imprimirVector(vec);
 writeln('***');
 imprimirVectorInverso(vec);
end.


{a) Implemente un módulo CargarVector que cree un vector de enteros conalosumo50valoresaleatorios.
Losvalores,generadosaleatoriamente(entreunmínimoymáximorecibidosporparámetro),debenseralmacenadosenel
vectorenelmismoordenquesegeneraron,hastaquesegenereelcero.}

{b) ImplementeunmóduloImprimirVectorquerecibaelvectorgeneragoena)
eimprimatodoslosvaloresdelvectorenelmismoordenqueestánalmacenados.Quécambiaríaparaimprimirenordeninverso?}

{c)
Escribaelcuerpoprincipalqueinvoquealosmódulosyaimplementados.}
