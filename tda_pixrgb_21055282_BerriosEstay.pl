
/*
  ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   
 |______| |______| |______| |______| |______| |______| |______| |______| |______| |______| |______|  
  _______   _____                 _____    _____  __   __  _____     _____   ____             _____  
 |__   __| |  __ \      /\       |  __ \  |_   _| \ \ / / |  __ \   / ____| |  _ \           |  __ \ 
    | |    | |  | |    /  \      | |__) |   | |    \ V /  | |__) | | |  __  | |_) |  ______  | |  | |
    | |    | |  | |   / /\ \     |  ___/    | |     > <   |  _  /  | | |_ | |  _ <  |______| | |  | |
    | |    | |__| |  / ____ \    | |       _| |_   / . \  | | \ \  | |__| | | |_) |          | |__| |
    |_|    |_____/  /_/    \_\   |_|      |_____| /_/ \_\ |_|  \_\  \_____| |____/           |_____/ 
  ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   
 |______| |______| |______| |______| |______| |______| |______| |______| |______| |______| |______|
 

-DOMINIOS 
	Y: Integer (Coordenada Y del pixel)
	X: Integer (Coordenada X del pixel)
	R: Integer (Valor entre 0 y 255)
	G: Integer (Valor entre 0 y 255)
	B: Integer (Valor entre 0 y 255)
	D: Integer (Posicion en profundidad del pixel)
	Pixel: List (pixrgb_d)
	Rout: Integer
	Gout: Integer
	Bout: Integer
	RGB: List ([R,G,B])
	L: List

-PREDICADOS
	pixrgb(Y,X,R,G,B,D,[Y,X,R,G,B,D]) { Aridad = 7 }
	getR(Pixel,Rout) { Aridad = 2 }
	getG(Pixel,Gout) { Aridad = 2 }
	getB(Pixel,Bout) { Aridad = 2 }
	getRGB(Pixel,RGB) { Aridad = 2 }
    isRGB(RGB) { Aridad = 1 }
	ispixrgb_d(L) { Aridad = 1 }

-METAS PRINCIPALES

	pixrgb

-METAS SECUNDARIAS
	getR, getG, getB, getRGB, ispixrgb_d
	
REPRESENTACION Pixrgb es una lista de 6 elementos, Coordenada Y, coordenada X, canal R, canal G, canal B y Profundidad
	
*/

% CLAUSULAS
% REGLAS

% Constructor -------------------------------------
%Dominio: Integer, Integer, Integer, Integer, Integer, Integer, List
%Descripción: Constructor de un pixrgb-d

pixrgb(Y,X,R,G,B,D,[Y,X,R,G,B,D]):-
    integer(Y), integer(X), integer(D),
    R>=0, 255>=R, 
    G>=0, 255>=G,
    B>=0, 255>=B.

% Selectores ----------------------------------------

%Dominio: Pixel, Integer
%Descripción: Obtener valor del canal R

getR([_,_,R|_],Rout):-
    isRGB(R),
    Rout = R.

%Dominio: Pixel, Integer
%Descripción: Obtener valor del canal G

getG([_,_,_,G|_],Gout):-
    isRGB(G),
    Gout = G.

%Dominio: Pixel, Integer
%Descripción: Obtener valor del canal B

getB([_,_,_,_,B|_],Bout):-
    isRGB(B),
    Bout = B.

%Dominio: Pixel, List
%Descripción: Obtiene una lista con los canales del pixrgb

getRGB(Pixel,RGB):-
    getR(Pixel,R),getG(Pixel,G),getB(Pixel,B),
    RGB = [R,G,B].
	
%Pertenencia ----------------------------------

isRGB(RGB):-
    RGB>=0, 255>=RGB.

%Dominio: List 
%Descripción: Verifica si la lista es un pixrgb-d

ispixrgb_d(L):-
    largolista(L,6),
    getY(L,Y),
    getX(L,X),
    getR(L,R),
    getG(L,G),
    getB(L,B),
    getDepth(L,D),
    pixrgb(Y,X,R,G,B,D,_).
	
%------------------------------------------------------------------------------------------------