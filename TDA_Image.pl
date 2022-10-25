
% otros
% largo de una lista

largolista([],0).
largolista([_|Y], N):-
    largolista(Y, N1),
    N is N1+1.

% Obtiene el numero minimo de una lista

getMinLista([H|T],Nmin):-
         getMinLista2(H,T,Nmin).
getMinLista2(H,[],Nmin):-
    H = Nmin.
getMinLista2(H1, [H2|T1], Nmin):-
          H2 =< H1, !,
          getMinLista2(H2, T1, Nmin).
getMinLista2(H1, [H2|T1], Nmin):-
          H2 >= H1,
          getMinLista2(H1, T1, Nmin).

% Elimina los elementos repetidos de una lista

delrepe([],[]).
delrepe([H|T],Lout):-
    member(H,T) -> delrepe(T,Lout);
    delrepe(T,L), 
    append([H],L,Lout).

% Obtener el resto de una lista
getTail(L,T):-
    [_|T] = L.

getPrimero([P|_],Pout):-
    Pout = P.

% Selectores ----------------------------------------

% selector: obtener Y

getY([Y|_],Yout):-
    Yout is Y.

% selector: obtener X

getX([_,X|_],Xout):-
    Xout is X.

% selector: obtener BIT

getBit([_,_,Bit|_],Bitout):-
    Bitout is Bit.

% selector: obtener HEX

getHex([_,_,H|_],Hout):-
    Hout = H.

% selector: obtener R

getR([_,_,R|_],Rout):-
    Rout = R.

% selector: obtener G

getG([_,_,_,G|_],Gout):-
    Gout = G.

% selector: obtener B

getB([_,_,_,_,B|_],Bout):-
    Bout = B.

% selector: Obtiene una lista con los canales del pixrgb

getRGB(Pix,RGB):-
    getR(Pix,R),getG(Pix,G),getB(Pix,B),
    RGB = [R,G,B].

% selector: obtener DEPTH

getDepth(Pix,Depthout):-
	reverse(Pix,[Depthout|_]).

% Constructores -----------------------------------------

% Constructor TDA pixbit-d

pixbit_d(Y,X,B,D,Pbout):-
    integer(Y), integer(X), integer(D),
    B>=0,
    1>=B,
    Pbout = [Y,X,B,D].

% Constructor TDA pixhex-d

pixhex_d(Y,X,H,D,[Y,X,H,D]):-
    integer(Y), integer(X), 
    string(H), integer(D).

% Constructor TDA pixrgb-d

pixrgb_d(Y,X,R,G,B,D,[Y,X,R,G,B,D]):-
    integer(Y), integer(X), integer(D),
    R>=0, 255>=R, 
    G>=0, 255>=G,
    B>=0, 255>=B.

% Pertenencia ----------------------------------

% Pertenencia: Verifica si la lista es un pixbit-d

ispixbit_d(L):-
    largolista(L,4),
    getY(L,Y),
    getX(L,X),
    getBit(L,B),
    getDepth(L,D),
    pixbit_d(Y,X,B,D,_).

% Pertenencia: Verifica si la lista es un pixhex-d

ispixhex_d(L):-
    largolista(L,4),
    getY(L,Y),
    getX(L,X),
    getHex(L,H),
    getDepth(L,D),
    pixhex_d(Y,X,H,D,_).

% Pertenencia: Verifica si la lista es un pixrgb-d

ispixrgb_d(L):-
    largolista(L,6),
    getY(L,Y),
    getX(L,X),
    getR(L,R),
    getG(L,G),
    getB(L,B),
    getDepth(L,D),
    pixrgb_d(Y,X,R,G,B,D,_).

%Pertenencia: homologo?
%Verifica si los elementos de la lista de entrada son de un mismo tipo de pixel

homologo(LP):-
    maplist(ispixhex_d,LP), !;
	maplist(ispixbit_d,LP), !;
    maplist(ispixrgb_d,LP), !.

comparar_area_pix(Ancho,Alto,P):-
    getY(P,Y),
    getX(P,X),
    Ancho>X,
    Alto>Y.

%Pertenencia: isdentrodelarea
%Verifica si los pixeles estan dentro dela rea de la imagen

isdentrodelarea(Ancho,Alto,LP):-
    maplist(comparar_area_pix(Ancho,Alto),LP).

% Constructor imagen --------------
% LP: Lista Pixeles

image(Ancho,Alto,LP,Iout):-
    integer(Alto), integer(Ancho),
    Largo=Alto*Ancho, largolista(LP,LL), Largo>=LL,
    homologo(LP),
    isdentrodelarea(Ancho,Alto,LP),
    Iout = [Alto,Ancho,LP].

% Selectores imagen

% getAlto

getAlto([Al|_],Alout):-
    Alout = Al.

%getAncho

getAncho([_,An|_],Anout):-
    Anout = An.

%getLP (Lista pixeles)

getLP([_,_,LP|_],LPnout):-
    LPnout = LP.

% Map? ---------
% imageIs___map

imageIsBitmap([_,_,LP|_]):-
    maplist(ispixbit_d,LP).

imageIsPixmap([_,_,LP|_]):-
    maplist(ispixrgb_d,LP).

imageIsHexmap([_,_,LP|_]):-
    maplist(ispixhex_d,LP).

% imageIsCompressed

imageIsCompressed([Ancho,Alto,LP|_]):-
    largolista(LP,LL),
    Area = Ancho*Alto,
    Area>LL.

% Ordena una imagen con sus pixeles desordenados

reordenar(Imagen,Iout):-
    getLP(Imagen,LP),
    getAncho(Imagen,Ancho),
    getAlto(Imagen,Alto),
    sort(1,=<,LP,S),
    sort(0,=<,S,S2),
    Iout = [Ancho,Alto,S2].

% FlipH

flopH(Ancho,Pix,Pout):- 
    A is Ancho-1,
    getX(Pix,X),
    Xnew is abs(X-A),
    getY(Pix,Y),
    getTail(Pix,T),
    getTail(T,T1),
    Pout = [Y,Xnew,T1].
    
imageFlipH(Imagen,Iout):-
    getAncho(Imagen,An), getAlto(Imagen,Al), getLP(Imagen,LP),
    R = [An,Al],
    maplist((flopH(An)),LP,R1),
    R2 = [R1],
    append(R,R2,I),
    reordenar(I,Iout).

% FlipV

flopV(Alto,Pix,Pout):-
    A is Alto-1,
    getY(Pix,Y),
    Ynew is abs(Y-A),
    getX(Pix,X),
    getTail(Pix,T),
    getTail(T,T1),
    append([Ynew,X],T1,Pout).
    
imageFlipV(Imagen,Iout):-
    getAncho(Imagen,An), getAlto(Imagen,Al), getLP(Imagen,LP),
    R = [An,Al],
    maplist((flopV(An)),LP,R1),
    R2 = [R1],
    append(R,R2,I),
    reordenar(I,Iout).

% Devuelve true si el pixel corresponde al cuadrante
% X1 x Y1 x X2 x Y2 x Pixel

seleccionapixel(X1,Y1,X2,Y2,[Y,X|_]):-
    Y >= Y1, X >= X1, Y =< Y2, X =< X2.

% Devuelve una imagen con los pixeles que pertenecen al cuadrante

cropear(Imagen,X1,Y1,X2,Y2,Icrop):-
    getAlto(Imagen,Alto), getAncho(Imagen,Ancho),
    getLP(Imagen,LP),
    include(seleccionapixel(X1,Y1,X2,Y2),LP,LPcrop),
    Icrop = [Ancho,Alto,LPcrop].

% Cambia la coordenada Y de un pixel respecto a la coord min de Y

cambiarY(MinY,[Y|T],Pout):-
    Ynew is Y-MinY, Pout = [Ynew|T].
	
% Cambia la coordenada X de un pixel respecto a la coord min de X

cambiarX(MinX,[Y,X|T],Pout):-
    Xnew is X-MinX, Pout = [Y,Xnew|T].

% CROP ---------------------

imageCrop(Imagen,X1,Y1,X2,Y2,Iout):-
    cropear(Imagen,X1,Y1,X2,Y2,Icrop),
    getLP(Icrop,LP),
    maplist(getY,LP,ListY), %ListY lista con todas las coords Y
    maplist(getX,LP,ListX), %ListX lista con todas las coords X
    getMinLista(ListY,MinY),!, %MinY coord minima en Y
    getMinLista(ListX,MinX),!, %MinX coord minima en X
    maplist(cambiarX(MinX),LP,OutX), %OutX lista LP con X corregidos
    maplist(cambiarY(MinY),OutX,LP2), %LP2 lista OutX con Y corregidos
    delrepe(ListY,ListY2), 
    delrepe(ListX,ListX2),
    largolista(ListY2,Alto), 
    largolista(ListX2,Ancho),
    Iout = [Ancho,Alto,LP2].

%  imgRGBToHex----------------------------------------

tablaHex(RGB,Strout):-
    RGB =< 9 ->  number_string(RGB,Strout) ; 
    RGB = 10 ->  Strout = "A" ;
    RGB = 11 ->  Strout = "B" ;
    RGB = 12 ->  Strout = "C" ;
    RGB = 13 ->  Strout = "D" ;
    RGB = 14 ->  Strout = "E" ;
    RGB = 15 ->  Strout = "F" .

rgbtohex(RGB,Srgb,Sout):-
    RGB =< 15, string_length(Srgb,Largo), Largo = 0 ->   number_string(0,Cero),
    tablaHex(RGB,RGBs), string_concat(Cero,RGBs,Sout1),string_concat(Sout1,Srgb,Sout);
    RGB =< 15, string_length(Srgb,Largo), Largo = 1 ->   tablaHex(RGB,RGBs),
    string_concat(RGBs,Srgb,Sout);
    RGB >= 16 ->  Q is RGB div 16, R is Q*16, R2 is R - RGB, abs(R2,R3), tablaHex(R3,R3s), 
    string_concat(R3s,Srgb,S1),rgbtohex(Q,S1,Sout).

pixRGBtoHex([Y,X,R,G,B,D],Pout):-
    rgbtohex(R,"",Rs),
    rgbtohex(G,"",Gs),
    rgbtohex(B,"",Bs),
    string_concat('#',Rs,S),
    string_concat(S,Gs,S1),
    string_concat(S1,Bs,RGBs),
    Pout = [Y,X,RGBs,D].

imgRGBToHex(Imagen,Iout):-
    getLP(Imagen,LP),
    getAncho(Imagen,Ancho),
    getAlto(Imagen,Alto),
    maplist(pixRGBtoHex,LP,LPout),
    Iout = [Ancho,Alto,LPout].

% HISTOGRAM ----------------------------------------------

contar(Cont,[],Color,[Color,Cont]):-!.
contar(Cont,[H|T],Color,ColorCont):-
    H =@= Color,
    T =@= [],
    NCont is Cont+1,
    ColorCont = [Color,NCont], !.
contar(Cont,[H|T],Color,ColorCont):-
    Color =@= H ->  NCont is Cont+1, contar(NCont,T,Color,ColorCont);
    Color \== H ->  contar(Cont,T,Color,ColorCont).

histogram(Imagen,Histogram):-
    imageIsHexmap(Imagen) ->  getLP(Imagen,LP), maplist(getHex,LP,LHexs),
    delrepe(LHexs,Colores),maplist(contar(0,LHexs),Colores,Histogram);
    imageIsBitmap(Imagen) ->  getLP(Imagen,LP), maplist(getBit,LP,LBits),
    delrepe(LBits,Colores),maplist(contar(0,LBits),Colores,Histogram);
    imageIsPixmap(Imagen) ->  getLP(Imagen,LP), maplist(getRGB,LP,LRGBs),
    delrepe(LRGBs,Colores),maplist(contar(0,LRGBs),Colores,Histogram).

% ROTATE90 -------------------------------------------------

rotate([Y,X|T],[X,Y|T]).

imageRotate90(Imagen,IR90):-
    imageFlipV(Imagen,Iflip),
    getLP(Iflip,LP),
    maplist(rotate,LP,LP1),
    getAncho(Imagen,Ancho),
    getAlto(Imagen,Alto),
    I2 = [Ancho,Alto,LP1],
    reordenar(I2,IR90).

% Compress ------------------------------------------------

% Obtiene el color del pixrgb_d, se utiliza para comparar si este es el mismo color que el color mas repetido (RGB)

compararRGB(RGB,Pix):-
    getR(Pix,R),
    getG(Pix,G),
    getB(Pix,B),
    RGB = [R,G,B].
	
% Obtiene el color del pixrgb_d, se utiliza para comparar si este es el mismo color que el color mas repetido (Bit)

compararBit(Bit,Pix):-
    getBit(Pix,B),
    Bit = B.

% Obtiene el color del pixrgb_d, se utiliza para comparar si este es el mismo color que el color mas repetido (Hex)

compararHex(Hex,Pix):-
    getHex(Pix,H),
    Hex =@= H.

% Elimina el color mas repetido de la imagen, devuelve la imagen con el color mas repetido eliminado

eliminarColorRepetido(Color,Imagen,Iout):-
	imageIsHexmap(Imagen) -> getLP(Imagen,LP), exclude(compararHex(Color),LP,LP2),
    getAncho(Imagen,Ancho), getAlto(Imagen,Alto), Iout = [Ancho,Alto,LP2];
    imageIsBitmap(Imagen) -> getLP(Imagen,LP), exclude(compararBit(Color),LP,LP2),
    getAncho(Imagen,Ancho), getAlto(Imagen,Alto), Iout = [Ancho,Alto,LP2];
    imageIsPixmap(Imagen) -> getLP(Imagen,LP), exclude(compararRGB(Color),LP,LP2),
    getAncho(Imagen,Ancho), getAlto(Imagen,Alto), Iout = [Ancho,Alto,LP2].
    

imageCompress(Imagen,ICompressed):-
    histogram(Imagen,H),
    sort(1,>=,H,H2), % Ordena de mayor a menor el histograma, para dejar al color mas repetido en el primer lugar de la lista histogram
    getPrimero(H2,HMR), 
	getPrimero(HMR,ColorMasrepetido), % Obtiene el color mas repetido
    eliminarColorRepetido(ColorMasrepetido,Imagen,ICom), % Se elimina el color mas repetido de la imagen
    append(ICom,[Imagen],ICompressed). % Se devuelve la imagen comprimida X imagen anterior (sin comprimir)