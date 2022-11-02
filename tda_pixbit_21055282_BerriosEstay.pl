
/*
  ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   
 |______| |______| |______| |______| |______| |______| |______| |______| |______| |______| |______|  
  _______   _____                 _____    _____  __   __  ____    _____   _______            _____  
 |__   __| |  __ \      /\       |  __ \  |_   _| \ \ / / |  _ \  |_   _| |__   __|          |  __ \ 
    | |    | |  | |    /  \      | |__) |   | |    \ V /  | |_) |   | |      | |     ______  | |  | |
    | |    | |  | |   / /\ \     |  ___/    | |     > <   |  _ <    | |      | |    |______| | |  | |
    | |    | |__| |  / ____ \    | |       _| |_   / . \  | |_) |  _| |_     | |             | |__| |
    |_|    |_____/  /_/    \_\   |_|      |_____| /_/ \_\ |____/  |_____|    |_|             |_____/ 
  ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   
 |______| |______| |______| |______| |______| |______| |______| |______| |______| |______| |______|

-DOMINIOS: 
	Y: Integer (Coordenada Y del pixel)
	X: Integer (Coordenada X del pixel)
	Bt: Integer (Bit: Valor 0 o 1)
	D: Integer (Posicion en profundidad del pixel)
	Pixel: List (pixbit_d)
	Yout: Integer
	Xout: Integer
	Bitout: Integer
	Depthout: Integer
	LargoLista: Integer
	L: List

-PREDICADOS: 
	pixbit(Y,X,Bt,D,[Y,X,Bt,D]) { Aridad = 5 }
	getY(Pixel,Yout) { Aridad = 2 }
	getX(Pixel,Xout) { Aridad = 2 }
	getBit(Pixel,Bitout) { Aridad = 2 }
	getDepth(Pixel,Depthout) { Aridad = 2 }
    isBit(Bt) { Aridad = 1 }
	ispixbit_d(L) { Aridad = 1 }
	largolista(Lista, LargoLista) { Aridad = 2 }

-METAS PRINCIPALES: 

	pixbit

-METAS SECUNDARIAS: 

	getY, getX, getBit, getDepth, largolista, ispixbit_d
	
REPRESENTACION: Pixbit es una lista de 4 elementos, Coordenada Y, coordenada X, Bit y Profundidad
	
*/

% CLAUSULAS:
% REGLAS:

%Constructor --------------------------------------

%Dominio: Integer, Integer, Integer, Integer, List
%Descripción: Constructor de un pixbit-d

pixbit(Y,X,Bt,D,[Y,X,Bt,D]):-
    integer(Y), integer(X), integer(D),
    Bt = 0,!; Bt = 1,!.
	
%Selectores ----------------------------------------

%Dominio: Pixel, Integer
%Descripción: Obteniene coordenada Y

getY([Y|_],Yout):-
    Yout is Y.

%Dominio: Pixel, Integer
%Descripción: Obteniene coordenada X

getX([_,X|_],Xout):-
    Xout is X.

%Dominio: Pixel, Integer
%Descripción: Obteniene valor del bit

getBit([_,_,Bt|_],Bitout):-
    isBit(Bt),
    Bitout is Bt.

%Dominio: Pixel, Integer
%Descripción: Obteniene valor de profundidad (Depth)

getDepth(Pixel,Depthout):-
	reverse(Pixel,[Depthout|_]).
	
%Pertenencia --------------------------------------

%Dominio: Integer
%Descripción: Verficia si es un bit

isBit(Bit):-
    Bit = 0,!; Bit = 1,!.

%Dominio: List 
%Descripción: Verifica si la lista es un pixbit-d

ispixbit_d(L):-
    largolista(L,4),
    getY(L,Y),
    getX(L,X),
    getBit(L,Bt),
    getDepth(L,D),
    pixbit(Y,X,Bt,D,_).

%Otros ---------------------------------------------

%Dominio: List, Integer
%Descripción: largo de una lista

largolista([],0). % Caso Base

largolista([_|Y], LargoLista):-
    largolista(Y, N1),
    LargoLista is N1+1.
	
%------------------------------------------------------------------------------------------------