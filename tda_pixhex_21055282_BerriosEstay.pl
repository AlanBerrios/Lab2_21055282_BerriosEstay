
:- include(tda_pixrgb_21055282_BerriosEstay).
/*
  ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   
 |______| |______| |______| |______| |______| |______| |______| |______| |______| |______| |______|  
  _______   _____                 _____    _____  __   __  _    _   ______  __   __           _____  
 |__   __| |  __ \      /\       |  __ \  |_   _| \ \ / / | |  | | |  ____| \ \ / /          |  __ \ 
    | |    | |  | |    /  \      | |__) |   | |    \ V /  | |__| | | |__     \ V /   ______  | |  | |
    | |    | |  | |   / /\ \     |  ___/    | |     > <   |  __  | |  __|     > <   |______| | |  | |
    | |    | |__| |  / ____ \    | |       _| |_   / . \  | |  | | | |____   / . \           | |__| |
    |_|    |_____/  /_/    \_\   |_|      |_____| /_/ \_\ |_|  |_| |______| /_/ \_\          |_____/ 
  ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   
 |______| |______| |______| |______| |______| |______| |______| |______| |______| |______| |______|  


-DOMINIOS: 
	Y: Integer (Coordenada Y del pixel)
	X: Integer (Coordenada X del pixel)
	Hx: String (String de un codigo hexadecimal #------)
	D: Integer (Posicion en profundidad del pixel)
	Pixel: pixhex_d
	Hout: String
	L: List

-PREDICADOS: 
	pixhex(Y,X,Hx,D,[Y,X,Hx,D]) { Aridad = 5 }
	getH(Pixel,Hout) { Aridad = 2 }
	ispixhex_d(L) { Aridad = 1 }

-METAS PRINCIPALES: 

	pixhex

-METAS SECUNDARIAS: 
	getH, ispixhex_d
	
REPRESENTACION: Pixhex es una lista de 4 elementos, Coordenada Y, coordenada X, Hex y Profundidad

*/

% CLAUSULAS:
% REGLAS:

% Constructor ---------------------------------

%Dominio: Integer, Integer, String, Integer, List
%Descripción: Constructor de un pixhex-d

pixhex(Y,X,Hx,D,[Y,X,Hx,D]):-
    integer(Y), integer(X), 
    string(Hx), integer(D).
	
% Selectores -----------------------------------

%Dominio: Pixel, Sting
%Descripción: Obtener color hexadecimal string del pixel

getHex([_,_,Hx|_],Hout):-
    string(Hx),
    Hout = Hx.

% Pertenencia ----------------------------------

%Dominio: List 
%Descripción: Verifica si la lista es un pixhex-d

ispixhex_d(L):-
    largolista(L,4),
    getY(L,Y),
    getX(L,X),
    getHex(L,Hx),
    getDepth(L,D),
    pixhex(Y,X,Hx,D,_).
	
%------------------------------------------------------------------------------------------------