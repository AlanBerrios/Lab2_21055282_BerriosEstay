
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