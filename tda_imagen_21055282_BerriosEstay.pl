
:- include(tda_pixhex_21055282_BerriosEstay).

/*
  ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   ______ 
 |______| |______| |______| |______| |______| |______| |______| |______| |______| |______| |______|
  _______   _____                 _____   __  __               _____   ______   _   _              
 |__   __| |  __ \      /\       |_   _| |  \/  |     /\      / ____| |  ____| | \ | |             
    | |    | |  | |    /  \        | |   | \  / |    /  \    | |  __  | |__    |  \| |             
    | |    | |  | |   / /\ \       | |   | |\/| |   / /\ \   | | |_ | |  __|   | .   |             
    | |    | |__| |  / ____ \     _| |_  | |  | |  / ____ \  | |__| | | |____  | |\  |             
    |_|    |_____/  /_/    \_\   |_____| |_|  |_| /_/    \_\  \_____| |______| |_| \_|             
  ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   ______ 
 |______| |______| |______| |______| |______| |______| |______| |______| |______| |______| |______|
 

-DOMINIOS: 
	Y: Integer (Coordenada Y del pixel)
	X: Integer (Coordenada X del pixel)
	Ancho: Integer (Ancho en pixeles de la imagen)
	Alto: Integer (Alto en pixeles de la imagen)
	LP: List (Lista de pixeles de la imagen)
	Iout: Image 
	LargoLista: Integer
	Pixel: pixbit_d o pixrgb_d o pixhex_d
	Imagen: image
	Anout: Integer
	Alout: Integer
	LPout: List
	H: Elemento (Head o cabeza de una lista) (Tiene variables como H1 o H2, representan lo mismo)
	T: Elemento (Tial o cola de una lista) (Tiene variables como T1 o T2, representan lo mismo)
	Nmin: Integer
	L: List
	Lout: Loist
	P: Elemento (Primer elemento de una lista)
	
-PREDICADOS: 
	image(Ancho,Alto,LP,Iout) { Aridad = 4 }
	homologo(LP) { Aridad = 1 }
	comparar_area_pix(Ancho,Alto,Pixel) { Aridad = 3 }
	isdentrodelarea(Ancho,Alto,LP) { Aridad = 3 }
	getAlto(Imagen,Alout) { Aridad = 2 }
	getAncho(Imagen,Anout) { Aridad = 2 }
	getLP(Imagen,LPout) { Aridad = 2 }
	getMinLista(L,Nmin) { Aridad = 2 }
	getMinLista2(H,L,Nmin) { Aridad = 3 }
	delrepe(L,Lout) { Aridad = 2 } 
	getTail(L,T) { Aridad = 2 }
	getPrimero(L,H) { Aridad = 2 }

-METAS PRINCIPALES: 

	image

-METAS SECUNDARIAS: 

	homologo, comparar_area_pix, isdentrodelarea, getAlto, getAncho, getLP, getMinLista, getMinLista2, delrepe, getTail, getPrimero
	
REPRESENTACION:

	"image" es una lista de 3 elementos principales, Ancho (Integer) que representa el ancho de pixeles
	Alto (Integer) que represente el alto en pixeles y LP o Lista de Pixeles (List) que contiene todos 
	los pixeles de la imagen

*/

% CLAUSULAS
% REGLAS:

% Constructor TDA pixhex-d ------------------------------

%Dominio: Integer, Integer, List, Image
%Descripción: Construye una imagen

image(Ancho,Alto,LP,Iout):-
    integer(Alto), integer(Ancho),
    Largo=Alto*Ancho, 
	largolista(LP,LargoLista), 
	Largo>=LargoLista,
    homologo(LP),
    isdentrodelarea(Ancho,Alto,LP),
    Iout = [Ancho,Alto,LP].

%Pertenencia --------------------------------------------

%Dominio: List
%Descripción: Verifica si los elementos de la lista de entrada son de un mismo tipo de pixel

homologo(LP):-
    maplist(ispixhex_d,LP), !;
	maplist(ispixbit_d,LP), !;
    maplist(ispixrgb_d,LP), !.

%Dominio: Integer, Integer, Pixel
%Descripción: Compara si un pixel esta dentro del area de una imagen

comparar_area_pix(Ancho,Alto,Pixel):-
    getY(Pixel,Y),
    getX(Pixel,X),
    Ancho>X,
    Alto>Y.

%Dominio: Integer, Integer, List
%Descripción: Verifica si los pixeles de una imagen estan dentro del area

isdentrodelarea(Ancho,Alto,LP):-
    maplist(comparar_area_pix(Ancho,Alto),LP).

%Selectores --------------------------------------------

%Dominio: Image, Integer
%Descripción: Obtener el ancho de una imagen
getAncho([_,An|_],Anout):-
    Anout = An.
	
%Dominio: Image, Integer
%Descripción: Obtener el alto de una imagen
getAlto([Al|_],Alout):-
    Alout = Al.

%Dominio: Image, List
%Descripción: Obtener la lista de pixeles de una imagen
getLP([_,_,LP|_],LPout):-
    LPout = LP.
	
% Otros -------------------------------------

%Dominio: List, Integer
%Descripción: Llama a getMinLista2

getMinLista([H|T],Nmin):-
	getMinLista2(H,T,Nmin).

%Dominio: Integer, List, Integer
%Descripción: Obtiene el numero minimo de una lista

%CASO BASE
getMinLista2(H,[],Nmin):-
    H = Nmin.
	
getMinLista2(H1, [H2|T1], Nmin):-
	H2 =< H1, !,
    getMinLista2(H2, T1, Nmin).
	
getMinLista2(H1, [H2|T1], Nmin):-
    H2 >= H1,
    getMinLista2(H1, T1, Nmin).
	
%Dominio: List, List
%Descripción: Elimina los elementos repetidos de una lista

%CASO BASE
delrepe([],[]).
delrepe([H|T],Lout):-
    member(H,T) -> delrepe(T,Lout);
    delrepe(T,L), 
    append([H],L,Lout).

%Dominio: List, Elemento
%Descripción: Obtener el primer elemento de una lista

getPrimero([P|_],H):-
    H = P.

%Dominio: List, List
%Descripción: Obtener el resto de una lista

getTail(L,T):-
    [_|T] = L.

% -------------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - IMAGEISBITMAP ------------------------------
-------------------------------------------------------------------------------

-DOMINIO:
	Imagen: image


-PREDICADO:
	imageIsBitmap(Imagen)

-META PRINCIPAL:
	imageIsBitmap

-METAS SECUNDARIAS:

-CLAUSULAS:
-HECHOS: */

% Descripción: Devuelve true o false dependiendo si la imagen es un Bitmap (Se compone de pixeles pixbit_d)

imageIsBitmap([_,_,LP|_]):-
    maplist(ispixbit_d,LP).
	
% -------------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - IMAGEISPIXMAP ------------------------------
-------------------------------------------------------------------------------

-DOMINIO: 
	Imagen: image

-PREDICADO:
	imageIsPixmap(Imagen) { Aridad = 1 }

-META PRINCIPAL:
	imageIsPixmap

-METAS SECUNDARIAS:

-CLAUSULAS:
-HECHOS: */

% Descripción: Devuelve true o false dependiendo si la imagen es un Pixmap (Se compone de pixeles pixrgb_d)

imageIsPixmap([_,_,LP|_]):-
    maplist(ispixrgb_d,LP).
	
% -------------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - IMAGEISHEXMAP ------------------------------
-------------------------------------------------------------------------------

-DOMINIO:
	Imagen: image

-PREDICADO:
	imageIsHexmap(Imagen) { Aridad = 1 }

-META PRINCIPAL:
	imageIsHexmap

-METAS SECUNDARIAS:

-CLAUSULAS:
-HECHOS: */

% Descripción: Devuelve true o false dependiendo si la imagen es un Hexmap (Se compone de pixeles pixhex_d)

imageIsHexmap([_,_,LP|_]):-
    maplist(ispixhex_d,LP).
		
% -------------------------------------------------------------------------------

/*

-------------------------------------------------------------------------------
---------------------  TDA IMAGE - IMAGEISCOMPRESSED --------------------------
-------------------------------------------------------------------------------

-DOMINIO: 
	Imagen: imagen

-PREDICADO:
	imageIsCompressed(Imagen) { Aridad = 1 }

-META PRINCIPAL:
	imageIsCompressed

-METAS SECUNDARIAS:

-CLAUSULAS:
-HECHOS: */

% Descripción: Devuelve true o false dependiendo si la imagen esta comprimida

imageIsCompressed(Imagen):-
	largolista(Imagen,LargoI),
	LargoI = 4,
	getLP(Imagen,LP),
    getAncho(Imagen,Ancho),
    getAlto(Imagen,Alto),
    largolista(LP,LargoLP),
    Area = Ancho*Alto,
    Area>LargoLP.
	
% -------------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - FLIPH ------------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: image
	Iout: image
	Ancho: Integer
	Pixel: pixbit_d o pixrgb_d o pixhex_d
	
-PREDICADOS:
	imageFlipH(Imagen,Iout) { Aridad = 2 }
	flopH(Ancho,Pixel,Pout) { Aridad = 2 }
	reordenar(Imagen,Iout) { Aridad = 2 }

-METAS PRINCIPALES:
	imageFlipH

-METAS SECUNDARIAS:
	flopH
	reordenar

-CLAUSULAS:
-HECHOS: */

%Dominio: Image, Image
%Descripción: Voltea horizontalmente una imagen

imageFlipH(Imagen,Iout):-
    getAncho(Imagen,An), getAlto(Imagen,Al), getLP(Imagen,LP),
    R = [An,Al],
    maplist((flopH(An)),LP,R1),
    R2 = [R1],
    append(R,R2,I),
    reordenar(I,Iout).
	
%Dominio: Integer, Pixel, Pixel
%Descripción: Voltea horizontalmente la coordenada X de un pixel respecto al ancho de una imagen

flopH(Ancho,Pix,Pout):- 
    A is Ancho-1,
    getX(Pix,X),
    Xnew is abs(X-A),
    getY(Pix,Y),
    getTail(Pix,T),
    getTail(T,T1),
    append([Y,Xnew],T1,Pout).

%Dominio: Image, Image
%Descripción: Ordena una imagen con sus pixeles desordenados

reordenar(Imagen,Iout):-
    getLP(Imagen,LP),
    getAncho(Imagen,Ancho),
    getAlto(Imagen,Alto),
    sort(1,=<,LP,S),
    sort(0,=<,S,S2),
    Iout = [Ancho,Alto,S2].
    
% -------------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - FLIPV ------------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: image
	Iout: image
	Alto: Integer
	Pixel: pixbit_d o pixrgb_d o pixhex_d
	
-PREDICADOS:
	imageFlipV(Imagen,Iout) { Aridad = 2 }
	flopV(Ancho,Pixel,Pout) { Aridad = 3 }
	
-METAS PRINCIPALES:
	imageFlipV

-METAS SECUNDARIAS:
	flopV

-CLAUSULAS:
-HECHOS: */

%Dominio: Image, Image
%Descripción: Voltea verticalmente una imagen

imageFlipV(Imagen,Iout):-
    getAncho(Imagen,An), getAlto(Imagen,Al), getLP(Imagen,LP),
    R = [An,Al],
    maplist((flopV(An)),LP,R1),
    R2 = [R1],
    append(R,R2,I),
    reordenar(I,Iout).

%Dominio: Integer, Pixel, Pixel
%Descripción: Voltea verticalmente la coordenada Y de un pixel respecto al alto de una imagen

flopV(Alto,Pix,Pout):-
    A is Alto-1,
    getY(Pix,Y),
    Ynew is abs(Y-A),
    getX(Pix,X),
    getTail(Pix,T),
    getTail(T,T1),
    append([Ynew,X],T1,Pout).
    
% -------------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - IMAGECROP ----------------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: image
	Iout: image
	X1: Integer
	Y1: Integer
	X2: Integer
	Y2: Integer
	Icrop: image
	MinX: Integer
	MinY: Integer
	Pout: Pixel
	
-PREDICADOS:
	imageCrop(Imagen,X1,Y1,X2,Y2,Iout) { Aridad = 6 }
	seleccionapixel(X1,Y1,X2,Y2,[Y,X|_]) { Aridad = 5 }
	cropear(Imagen,X1,Y1,X2,Y2,Icrop) { Aridad = 6 }
	cambiarY(MinY,[Y|T],Pout) { Aridad = 3 }
	cambiarX(MinX,[Y,X|T],Pout) { Aridad = 3 }
	
-METAS PRINCIPALES:
	imageCrop

-METAS SECUNDARIAS:
	seleccionapixel, cropear, cambiarY, cambiarX

-CLAUSULAS:
-HECHOS: */

%Dominio: Image, Integer, Integer, Integer, Integer, Image
%Descripción: Recortar una imágen a partir de un cuadrante.

imageCrop(Imagen,X1,Y1,X2,Y2,Iout):-
    cropear(Imagen,X1,Y1,X2,Y2,Icrop),
    getLP(Icrop,LP),
    maplist(getY,LP,ListY), %ListY: lista con todas las coords Y
    maplist(getX,LP,ListX), %ListX: lista con todas las coords X
    getMinLista(ListY,MinY),!, %MinY: coord minima en Y
    getMinLista(ListX,MinX),!, %MinX: coord minima en X
    maplist(cambiarX(MinX),LP,OutX), %OutX: lista LP con X corregidos
    maplist(cambiarY(MinY),OutX,LP2), %LP2: lista OutX con Y corregidos
    delrepe(ListY,ListY2), 
    delrepe(ListX,ListX2),
    largolista(ListY2,Alto), 
    largolista(ListX2,Ancho),
    Iout = [Ancho,Alto,LP2].

%Dominio: Imagen, Integer, Integer, Integer, Integer, Imagen
%Descripción: Devuelve una la imagen con los pixeles que con el cuadrante

cropear(Imagen,X1,Y1,X2,Y2,Icrop):-
    getAlto(Imagen,Alto), getAncho(Imagen,Ancho),
    getLP(Imagen,LP),
    include(seleccionapixel(X1,Y1,X2,Y2),LP,LPcrop),
    Icrop = [Ancho,Alto,LPcrop].
	
%Dominio: Integer, Integer, Integer, Integer, Pixel
%Descripción: Devuelve true si el pixel corresponde al cuadrante

seleccionapixel(X1,Y1,X2,Y2,[Y,X|_]):-
    Y >= Y1, X >= X1, Y =< Y2, X =< X2.

%Dominio: Integer, Pixel, Pixel
%Descripción: Cambia la coordenada Y de un pixel respecto a la coord min de Y

cambiarY(MinY,[Y|T],Pout):-
    Ynew is Y-MinY, Pout = [Ynew|T].
	
%Dominio: Integer, Pixel, Pixel
%Descripción: Cambia la coordenada X de un pixel respecto a la coord min de X

cambiarX(MinX,[Y,X|T],Pout):-
    Xnew is X-MinX, Pout = [Y,Xnew|T].

% -------------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - IMAGERGBTOHEX ----------------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: image
	Iout: image
	Icrop: image
	RGB: Integer
	Strout: String
	Sout: String
	Srgb: String
	Pixel: Pixel
	Pout: List
	
-PREDICADOS:
	imageRGBToHex(Imagen,Iout) { Aridad = 2 }
	tablaHex(RGB,Strout) { Aridad = 2 }
	rgbtohex(RGB,Srgb,Sout) { Aridad = 3 }
	pixRGBtoHex(Pixel,Pout) { Aridad = 2 }
	
-METAS PRINCIPALES:
	imageRGBtoHex

-METAS SECUNDARIAS:
	tablaHex, rgbtohex, pixRGBtoHex

-CLAUSULAS:
-HECHOS: */

%Dominio: Image, Image
%Descripción: Transforma una imagen desde una representación RGB a una representación HEX.

imageRGBToHex(Imagen,Iout):-
    getLP(Imagen,LP),
    getAncho(Imagen,Ancho),
    getAlto(Imagen,Alto),
    maplist(pixRGBtoHex,LP,LPout),
    Iout = [Ancho,Alto,LPout].

%Dominio: Integer, String
%Descripción: Transforma un numero de 0 a 15 con su correspondiente en hexadecimal

tablaHex(RGB,Strout):-
    RGB =< 9 ->  number_string(RGB,Strout) ; 
    RGB = 10 ->  Strout = "A" ;
    RGB = 11 ->  Strout = "B" ;
    RGB = 12 ->  Strout = "C" ;
    RGB = 13 ->  Strout = "D" ;
    RGB = 14 ->  Strout = "E" ;
    RGB = 15 ->  Strout = "F" .

%Dominio: Integer, String, String
%Descripción: Transforma un numero a su representación en Hexadecimal

rgbtohex(RGB,Srgb,Sout):-
    RGB =< 15, string_length(Srgb,Largo), Largo = 0 ->   number_string(0,Cero),
    tablaHex(RGB,RGBs), string_concat(Cero,RGBs,Sout1),string_concat(Sout1,Srgb,Sout);
    RGB =< 15, string_length(Srgb,Largo), Largo = 1 ->   tablaHex(RGB,RGBs),
    string_concat(RGBs,Srgb,Sout);
    RGB >= 16 ->  Q is RGB div 16, R is Q*16, R2 is R - RGB, abs(R2,R3), tablaHex(R3,R3s), 
    string_concat(R3s,Srgb,S1),rgbtohex(Q,S1,Sout).

%Dominio: Pixel, Pixel
%Descripción: Transforma un pixrgb_d a pixhex_d

pixRGBtoHex([Y,X,R,G,B,D],Pout):-
    rgbtohex(R,"",Rs),
    rgbtohex(G,"",Gs),
    rgbtohex(B,"",Bs),
    string_concat('#',Rs,S),
    string_concat(S,Gs,S1),
    string_concat(S1,Bs,RGBs),
    Pout = [Y,X,RGBs,D].

% -------------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - HISTOGRAM ----------------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: image
	Histogram: List (Lista que contiene Listas de la siguiente representación: [Color,Cantidad de dicho color]
	Cont: Integer
	Color: Elemento (Para pixbit_d es un Integer, para pixrgb_d es una lista, para pixhex_d es un String)
	H: Elemento
	T: Lista
	L: List
	
-PREDICADOS:
	histogram(Imagen,Histogram) { Aridad = 2 }
	contar(Cont,LP,Color,[Color,Cont]) { Aridad = 3 }
	
-METAS PRINCIPALES:
	histogram

-METAS SECUNDARIAS:
	contar

-CLAUSULAS:
-HECHOS: */

% HISTOGRAM ----------------------------------------------

%Dominio: Image, List
%Descripción: Retorna un histograma de frecuencias a 
% partir de los colores en cada una de las imágenes

histogram(Imagen,Histogram):-
    imageIsHexmap(Imagen) ->  getLP(Imagen,LP), maplist(getHex,LP,LHexs),
    delrepe(LHexs,Colores),maplist(contar(0,LHexs),Colores,Histogram);
    imageIsBitmap(Imagen) ->  getLP(Imagen,LP), maplist(getBit,LP,LBits),
    delrepe(LBits,Colores),maplist(contar(0,LBits),Colores,Histogram);
    imageIsPixmap(Imagen) ->  getLP(Imagen,LP), maplist(getRGB,LP,LRGBs),
    delrepe(LRGBs,Colores),maplist(contar(0,LRGBs),Colores,Histogram).
	
%Dominio: Integer, List, Elemento, List
%Descripción: Para un color, cuenta su cantidad en la lista de pixeles de una imagen

% CASO BASE

contar(Cont,[],Color,[Color,Cont]):-!. 

contar(Cont,[H|T],Color,ColorCont):-
    H =@= Color,
    T =@= [],
    NCont is Cont+1,
    ColorCont = [Color,NCont], !.
	
contar(Cont,[H|T],Color,ColorCont):-
    Color =@= H ->  NCont is Cont+1, contar(NCont,T,Color,ColorCont);
    Color \== H ->  contar(Cont,T,Color,ColorCont).

% -------------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - ROTATE90 ----------------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: image
	IR90: image
	
-PREDICADOS:
	imageRotate90(Imagen,IR90) { Aridad = 2 }
	rotate(Pixel,Pixel) { Aridad = 2 }
	
-METAS PRINCIPALES:
	imageRotate90

-METAS SECUNDARIAS:
	rotate

-CLAUSULAS:
-HECHOS: */

%Dominio: Image, Image
%Descripción: rota la imagen 90° a la derecha.

imageRotate90(Imagen,IR90):-
    imageFlipV(Imagen,Iflip),
    getLP(Iflip,LP),
    maplist(rotate,LP,LP1),
    getAncho(Imagen,Ancho),
    getAlto(Imagen,Alto),
    I2 = [Ancho,Alto,LP1],
    reordenar(I2,IR90).
	
%Dominio: Pixel, Pixel
%Descripción: Invierte la coordenada Y con la coordenada X de un pixel

rotate([Y,X|T],[X,Y|T]).

% -------------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - IMAGECOMPRESS ------------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: image
	ICompressed: image
	RGB: List
	Pix: Pixel
	Bit: Integer (0 o 1)
	Hex: String
	Color: RGB o Bit o Hex
	Iout: image
	
-PREDICADOS:
	imageCompress(Imagen,ICompressed) { Aridad = 2 } 
	compararRGB(RGB,Pix) { Aridad = 2 }
	compararBit(Bit,Pix) { Aridad = 2 }
	compararHex(Hex,Pix) { Aridad = 2 }
	eliminarColorRepetido(Color,Imagen,Iout) { Aridad = 3 }
	
-METAS PRINCIPALES:
	imageCompress

-METAS SECUNDARIAS:
	compararBit
	compararRGB
	compararHex
	eliminarColorRepetido

-CLAUSULAS:
-HECHOS: */

%Dominio: Image, Image
%Descripción: Comprime una imágen eliminando aquellos pixeles con el color más frecuente

imageCompress(Imagen,ICompressed):-
    histogram(Imagen,H),
    sort(1,>=,H,H2), % Ordena de mayor a menor el histograma, para dejar al color mas repetido en el primer lugar de la lista histogram
    getPrimero(H2,HMR), 
	getPrimero(HMR,ColorMasrepetido), % Obtiene el color mas repetido
    eliminarColorRepetido(ColorMasrepetido,Imagen,ICom), % Se elimina el color mas repetido de la imagen
    append(ICom,[Imagen],ICompressed). % Se devuelve la imagen comprimida X imagen anterior (sin comprimir)

%Dominio: List, Pixel
%Descripción: Obtiene el color del pixrgb_d, se utiliza para comparar si este es el mismo color que el color mas repetido (RGB)

compararRGB(RGB,Pix):-
    getR(Pix,R),
    getG(Pix,G),
    getB(Pix,B),
    RGB = [R,G,B].

%Dominio: Integer, Pixel	
%Descripción: Obtiene el color del pixbit_d, se utiliza para comparar si este es el mismo color que el color mas repetido (Bit)

compararBit(Bit,Pix):-
    getBit(Pix,B),
    Bit = B.

%Dominio: String, Pixel
%Descripción: Obtiene el color del pixhex_d, se utiliza para comparar si este es el mismo color que el color mas repetido (Hex)

compararHex(Hex,Pix):-
    getHex(Pix,H),
    Hex =@= H.

%Dominio: (RGB o Bit o Hex), Image, Image
%Descripción: Elimina el color mas repetido de una imagen, devuelve la imagen con el color mas repetido eliminado

eliminarColorRepetido(Color,Imagen,Iout):-
	imageIsHexmap(Imagen) -> getLP(Imagen,LP), exclude(compararHex(Color),LP,LP2),
    getAncho(Imagen,Ancho), getAlto(Imagen,Alto), Iout = [Ancho,Alto,LP2];
    imageIsBitmap(Imagen) -> getLP(Imagen,LP), exclude(compararBit(Color),LP,LP2),
    getAncho(Imagen,Ancho), getAlto(Imagen,Alto), Iout = [Ancho,Alto,LP2];
    imageIsPixmap(Imagen) -> getLP(Imagen,LP), exclude(compararRGB(Color),LP,LP2),
    getAncho(Imagen,Ancho), getAlto(Imagen,Alto), Iout = [Ancho,Alto,LP2].
    

% -------------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - IMAGECHANGEPIXEL ---------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: Image
	Pixel: Pixel
	An: Integer
	Al: Integer
	LP: List
	T: List
	NPix: Pixel
	Iout: Image
	Y: Integer
	X: Integer
	Pout: Pixel
	
-PREDICADOS:
	imageChangePixel(Imagen,NPix,Iout) { Aridad = 3 }
	cambiarPix(Pixel,[Y,X|_],Pout) { Aridad = 3 }
	
-METAS PRINCIPALES:
	imageCompress

-METAS SECUNDARIAS:
	

-CLAUSULAS:
-HECHOS: */

%Dominio: Image, Pixel, Image
%Descripción: Permite reemplazar un píxel en una imagen.

imageChangePixel([An,Al,LP|T],NPix,Iout):-
    maplist(cambiarPix(NPix),LP,LPNew),
    Iout = [An,Al,LPNew|T].
	
%Dominio: Pixel, Pixel, Pixel 
%Descripción: Si las coordenadas X e Y coinciden de los dos pixeles, se devuelve el pixel a cambiar
% Si no, se queda como esta
	
cambiarPix([Y1,X1|NT],[Y,X|_],Pout):-
    Y1 = Y, X1 = X, Pout = [Y,X|NT],!.
	
cambiarPix([Y1,X1|_],[Y,X|T],Pout):-
    Y1 \= Y -> Pout = [Y,X|T];
    X1 \= X ->  Pout = [Y,X|T].
 
 % ----------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - INVERTCOLORRGB -----------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: Image
	Y: Integer
	X: Integer
	R: Integer
	G: Integer
	B: Integer
	D: Integer
	An: Integer
	Al: Integer
	LP: List
	T: List

	
-PREDICADOS:
	imageInvertColorRGB([An,Al,LP|T],[An,Al,LPI|T]) { Aridad = 2 }
	pixinvertColorRGB([Y,X,R,G,B,D],[Y,X,NewR,NewG,NewB,D]) { Aridad = 2 }
	
-METAS PRINCIPALES:
	imageInvertColorRGB

-METAS SECUNDARIAS:
	pixinvertColorRGB

-CLAUSULAS:
-HECHOS: */

%Dominio: Image, Image
%Descripción: Predicado que permite obtener el color simétricamente opuesto en cada canal dentro de un pixel.
 
imageInvertColorRGB([An,Al,LP|T],[An,Al,LPI|T]):-
    maplist(pixinvertColorRGB,LP,LPI).
	
%Dominio: Pixel, Pixel
%Descripción: Invierte el color de un pixrgb_d
	
pixinvertColorRGB([Y,X,R,G,B,D],[Y,X,NewR,NewG,NewB,D]):-
    R1 is R-255,abs(R1,NewR),
    G1 is G-255,abs(G1,NewG),
    B1 is B-255,abs(B1,NewB).
   
 % ----------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - IMAGETOSTRING ------------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: Image
	IString: String
	Pix: Pixel
	CString: String
	Ancho: Integer
	NCString: String

	
-PREDICADOS:
	imageToString(Imagen,IString) { Aridad = 2 }
	colortoString(Pix,CString) { Aridad = 2 }
	setNewLine(Ancho,Pix,NCString) { Aridad = 3 }

	
-METAS PRINCIPALES:
	imageToString

-METAS SECUNDARIAS:
	colortoString
	setNewLine

-CLAUSULAS:
-HECHOS: */

%Dominio: Image, String
%Descripción: Predicado que transforma una imagen a una representación string

imageToString(Imagen,IString):-
    getAncho(Imagen,Ancho), getLP(Imagen,LP),
    maplist(setNewLine(Ancho),LP,L),
	atomics_to_string(L,"",IString).
	
%Dominio: Pixel, String
%Descripción: Transforma el color del pixel a string
    
colortoString(Pix,CString):-
    ispixhex_d(Pix) ->  getHex(Pix,CString);
    ispixbit_d(Pix) ->  getBit(Pix,Bit),number_string(Bit,CString);
    ispixrgb_d(Pix) ->  getR(Pix,R), getG(Pix,G),getB(Pix,B),
    atomics_to_string([R,G,B],"\t", S),concat("[",S,S1),concat(S1,"]",CString).

%Dominio: Integer, Pixel, String
%Descripción: Agrega el salto de linea a un pixel dependiendo si esta en el limite del ancho de la imagen

setNewLine(Ancho,Pix,NCString):-
    getX(Pix,X), An is Ancho-1, An = X ->  colortoString(Pix,S), concat(S,"\n",NCString);
    getX(Pix,X), An is Ancho-1, An\= X ->  colortoString(Pix,S), concat(S,"\t",NCString).
    

 % ----------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - DEPTHLAYERS --------------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: Image
	DepthLayers: List
	LOLDOut: List (List Of List Depth Out)
	LOLD: List (List Of List Depth)
	LOLDRellenado: List
	LOLDOut: List
	LOPD: List (LP of Depth)
	LPODRellenado: List
	LPODOut: List
	LP: List (Lista de pixeles)
	LPout: List
	DL: List (Depth List)
	Depth: Integer
	D: Integer (Depth)
	Pix: Pixel
	NPix: Pixel
	MaxY: Integer
	MaxX: Integer
	ContX: Integer
	ContY: Integer
	L: List
	O1: List
	Out: List
	Pout: Pixel
	Iout: Image
	
	
-PREDICADOS:
	imageDepthLayers(Imagen,DepthLayers) { Aridad = 2 } 
	getDepthList(Imagen,DL) { Aridad = 2 } 
	selectPixDepth(Depth,Pix,Pout) { Aridad = 3 } 
	selectLPDepth(LP,D,H1) { Aridad = 3 } 
	listOfLPDepth(Imagen,LOLD) { Aridad = 2 } 
	rellenarBit(Depth,Pix,NPix) { Aridad = 3 } 
	rellenarPix(Depth,Pix,NPix) { Aridad = 3 } 
	rellenarHex(Depth,Pix,NPix) { Aridad = 3 } 
	getDepthLPOD(LPOD,Depth) { Aridad = 2 } 
	rellenarBit2(LPOD,LPODRellenado) { Aridad = 2 } 
	rellenarPix2(LPOD,LPODRellenado) { Aridad = 2 } 
	rellenarHex2(LPOD,LPODRellenado) { Aridad = 2 } 
	rellenarPixBlancos(Imagen,LOLDRellenado) { Aridad = 2 } 
	agregarAncAlt(An,Al,LPOD,LPODOut) { Aridad = 4 } 
	agregarAncAlt2(Imagen,LOLDOut) { Aridad = 2 } 
	corregirPixel(MaxY,MaxX,ContX,ContY,L,O1,Out) { Aridad = 7 } 
	corregirPixelesImagen(Imagen,Iout) { Aridad = 2 } 

	
-METAS PRINCIPALES:
	imageToString

-METAS SECUNDARIAS:
	colortoString
	setNewLine

-CLAUSULAS:
-HECHOS: */

%Dominio: Image, List
%Descripción: Predicado que permite separar una imágen en capas en base a la profundidad en que se sitúan los pixeles

imageDepthLayers(Imagen,DepthLayers):-
    agregarAncAlt2(Imagen,LOLDOut),!, %Se crea la lista de imagenes por profundidad
    maplist(corregirPixelesImagen,LOLDOut,DepthLayers),!. %Se corrigen los pixeles de la lista de imagenes por profundidad
	
%Dominio: Image, List
%Descripción: Se obtiene la lista de todas las diferentes profundidades de la imagen sin repetirse
 	
getDepthList(Imagen,DL):- 
    getLP(Imagen,LP),
    maplist(getDepth,LP,DL1),
    delrepe(DL1,DL2),
    sort(0,=<,DL2,DL).
	
%Dominio: Integer, Pixel, Pixel
%Descripción: Si el pixel es de la misma profundidad que la profundidad dada, se queda igual, si no, se reemplaza por una lista vacia

selectPixDepth(Depth,Pix,Pout):-
    getDepth(Pix,D), Depth = D ->  Pout = Pix;
    getDepth(Pix,D), Depth \= D ->  Pout = [].
	
%Dominio: List, Integer, List
%Descripción: Aplica selectPixDepth a una lista de pixeles

selectLPDepth(LP,D,LPout):-
    maplist(selectPixDepth(D),LP,LPout).
	
%Dominio: Image, List
%Descripción: Obtiene una lista de listas de pixeles por cada profunidad de la imagen

listOfLPDepth(Imagen,LOLD):-
    getLP(Imagen,LP),
	getDepthList(Imagen,DL),
	maplist(selectLPDepth(LP),DL,LOLD).
	
%Dominio: Integer, Pixel, Pixel
%Descripción: "Rellena" un Pixel "vacio" con un pixel blanco bit
	
rellenarBit(Depth,Pix,NPix):-
    Pix = [] ->  NPix = [0,0,1,Depth];
    Pix \= [] ->  NPix = Pix.
	
%Dominio: Integer, Pixel, Pixel
%Descripción: "Rellena" un Pixel "vacio" con un pixel blanco RGB
	
rellenarPix(Depth,Pix,NPix):-
    Pix = [] ->  NPix = [0,0,255,255,255,Depth];
    Pix \= [] ->  NPix = Pix.
	
%Dominio: Integer, Pixel, Pixel
%Descripción: "Rellena" un Pixel "vacio" con un pixel blanco hex

rellenarHex(Depth,Pix,NPix):-
    Pix = [] ->  NPix = [0,0,"#FFFFFF",Depth];
    Pix \= [] ->  NPix = Pix.
	
%Dominio: List, Integer
%Descripción: Obtiene la profundidad de una lista LPOD
    
getDepthLPOD(LPOD,Depth):-
    sort(0,>=,LPOD,L),
    getPrimero(L,P),
    getDepth(P,Depth).
	
%Dominio: List, List
%Descripción: Rellena una lista LPOD con pixeles blancos bit

rellenarBit2(LPOD,LPODRellenado):-
    getDepthLPOD(LPOD,Depth),
    maplist(rellenarBit(Depth),LPOD,LPODRellenado).
	
%Dominio: List, List
%Descripción: Rellena una lista LPOD con pixeles blancos RGB

rellenarPix2(LPOD,LPODRellenado):-
    getDepthLPOD(LPOD,Depth),
    maplist(rellenarPix(Depth),LPOD,LPODRellenado).
	
%Dominio: List, List
%Descripción: Rellena una lista LPOD con pixeles blancos Hex

rellenarHex2(LPOD,LPODRellenado):-
    getDepthLPOD(LPOD,Depth),
    maplist(rellenarHex(Depth),LPOD,LPODRellenado).  
	
%Dominio: Image, List
%Descripción: Rellena la lista LOLD de una imagen con los pixeles blancos correspondientes al map de la imagen

rellenarPixBlancos(Imagen,LOLDRellenado):-
    imageIsPixmap(Imagen) ->  listOfLPDepth(Imagen,LOLD),maplist(rellenarPix2,LOLD,LOLDRellenado);
    imageIsBitmap(Imagen) ->  listOfLPDepth(Imagen,LOLD),maplist(rellenarBit2,LOLD,LOLDRellenado);
    imageIsHexmap(Imagen) ->  listOfLPDepth(Imagen,LOLD),maplist(rellenarHex2,LOLD,LOLDRellenado).
	
%Dominio: Integer, Integer, List, List
%Descripción: Agrega el ancho y alto a la lista LP para construir una imagen


agregarAncAlt(An,Al,LPOD,LPODOut):-
    LPODOut = [An,Al,LPOD].
	
%Dominio: Image, List
%Descripción: Se agrega el ancho y el alto de la imagen a cada lista de pixeles por profundidad para construir una lista de imagenes por profundidad

agregarAncAlt2(Imagen,LOLDOut):-
    rellenarPixBlancos(Imagen,LOLD),
    getAncho(Imagen,An), getAlto(Imagen,Al),
    maplist(agregarAncAlt(An,Al),LOLD,LOLDOut).
	
%Dominio: Integer, Integer, Integer, Integer, List, List, List
%Descripción: Dependiendo de los limites de la imagen, se corrigen las coordenadas de los pixeles blancos de la LP de la imagen
%Nota: L representa la LP de la imagen

corregirPixel(MaxY,MaxX,ContX,ContY,L,O1,Out):-
    MaxY = ContY,MaxX = ContX, getPrimero(L,P),getTail(P,T),getTail(T,T1),
    O2 = [ContX,ContY|T1], append(O1,[O2],Out).

corregirPixel(MaxY,MaxX,MaxX,ContY,[H|T],O1,Out):-
    getTail(H,TH),getTail(TH,TTH),
    NcontY is ContY+1,
    O2 = [ContY,MaxX|TTH],append(O1,[O2],O3), corregirPixel(MaxY,MaxX,0,NcontY,T,O3,Out).
                                        
corregirPixel(MaxY,MaxX,ContX,ContY,[H|T],O1,Out):-
    getTail(H,TH),getTail(TH,TTH),
    NcontX is ContX+1,
    O2 = [ContY,ContX|TTH],append(O1,[O2],O3),
    corregirPixel(MaxY,MaxX,NcontX,ContY,T,O3,Out).
	
%Dominio: Image, Image
%Descripción: Corrige las coordenadas de los pixeles de la imagen

corregirPixelesImagen(Imagen,Iout):-
    getAncho(Imagen,Ancho),getAlto(Imagen,Alto),
    MaxX is Ancho-1, MaxY is Alto-1,
    getLP(Imagen,LP),
    corregirPixel(MaxY,MaxX,0,0,LP,_,LP1),
    Iout = [Ancho,Alto,LP1].



 % ----------------------------------------------------------------------------
/* ----------------------------------------------------------------------------
---------------------  TDA IMAGE - IMAGEDECOMPRESS ----------------------------
-------------------------------------------------------------------------------

-DOMINIOS:
	Imagen: Image
	IOut: Image
	
-PREDICADOS:
	imageDecompress(Imagen,IOut) { Aridad = 2 }

-METAS PRINCIPALES:
	imageDecompress

-METAS SECUNDARIAS:

-CLAUSULAS:
-HECHOS: */

%Dominio: Image, Image
%Descripción: Predicado que permite descomprimir una imagen comprimida.

imageDecompress(Imagen,IOut):-
	imageIsCompressed(Imagen),
    reverse(Imagen,I),
	getPrimero(I,IOut).