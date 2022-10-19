
% largo de una lista

largolista([],0).
largolista([_|Y], N):-
    largolista(Y, N1),
    N is N1+1.
	
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
    Rout is R.

% selector: obtener G

getG([_,_,_,G|_],Gout):-
    Gout is G.

% selector: obtener B

getB([_,_,_,_,B|_],Bout):-
    Bout is B.

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