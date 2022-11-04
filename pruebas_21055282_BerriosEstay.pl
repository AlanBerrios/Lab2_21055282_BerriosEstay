:- include(tda_imagen_21055282_BerriosEstay).

/*
Probar que se puede generar una imagen pixbit
pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), 
pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap(I), imageToString(I, Str),write(Str).

Probar que imageIsBitMap detecta cuando se tiene una imagen en hex o en rgb -----------------------------------------------------------------------------

pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap( I ).

Estos casos deben dar false:

pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), 
pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap( I ).


pixrgb( 0, 0, 200, 200, 200, 10, PA), pixrgb( 0, 1, 200, 200, 200, 20, PB), pixrgb( 1, 0, 190, 190, 190, 30, PC), 
pixrgb( 1, 1, 190, 190, 190, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap( I ).

Probar que se puede generar una imagen pixhex -----------------------------------------------------------------------------------------------------------

pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), 
image( 2, 2, [PA, PB, PC, PD], I), imageToString(I, Str),write(Str).

Probar que imageIsHexmap detecta cuando se tiene una imagen en bit o en rgb -----------------------------------------------------------------------------

pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), 
pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsHexmap( I ).

Estos casos deben dar false:

pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsHexmap( I ).


pixrgb( 0, 0, 200, 200, 200, 10, PA), pixrgb( 0, 1, 200, 200, 200, 20, PB), 
pixrgb( 1, 0, 190, 190, 190, 30, PC), pixrgb( 1, 1, 190, 190, 190, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsHexmap( I ).



Probar que se puede generar una imagen pixrgb ------------------------------------------------------------------------------------------------------------

pixrgb( 0, 0, 255, 0, 0, 10, PA), pixrgb( 0, 1, 255, 0, 0, 20, PB), 
pixrgb( 1, 0, 0, 0, 255, 30, PC), pixrgb( 1, 1, 0, 0, 255, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageToString(I, Str),write(Str).



Probar que imageIsPixmap detecta cuando se tiene una imagen en hex o en bit. -----------------------------------------------------------------------------

pixrgb( 0, 0, 200, 200, 200, 10, PA), pixrgb( 0, 1, 200, 200, 200, 20, PB), pixrgb( 1, 0, 190, 190,190, 30, PC), 
pixrgb( 1, 1, 190, 190, 190, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap( I ).



Estos casos deben dar false:

pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap( I ).


pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), 
pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap( I ).


Convierte una imagen RGB a HEX y comprueba con los predicados de pertenencia, luego convierte a string y muestra por pantalla: ---------------------------

pixrgb( 0, 0, 200, 200, 200, 10, PA), pixrgb( 0, 1, 200, 200, 200, 20, PB), pixrgb( 1, 0, 190, 190,190, 30, PC), 
pixrgb( 1, 1, 190, 190, 190, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap( I ), imageRGBToHex(I, I2), imageIsHexmap(I2), imageToString(I2, Str), write(Str).

Comprime una imagen, luego descomprime y debe resultar la misma imagen original: -------------------------------------------------------------------------

pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), 
pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageCompress(I, I2), imageDecompress(I2, I3).

En el ejemplo anterior “I” debería ser igual a “I3”

Si se rota una imagen 4 veces en 90°, debería resultar la imagen original: --------------------------------------------------------------------------------

pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), 
image( 2, 2, [PA, PB, PC, PD], I), imageRotate90(I, I2), imageRotate90(I2, I3), imageRotate90(I3, I4), imageRotate90(I4, I5).

En el ejemplo anterior “I” debería ser igual a “I5”

Si se rota una imagen en 90° que tiene el mismo color y profundidad en todos sus píxeles, entonces la imagen resultante debería ser la misma imagen original.

pixhex( 0, 0, "#FF0000", 30, PA), pixhex( 0, 1, "#FF0000", 30, PB), pixhex( 1, 0, "#FF0000", 30, PC), pixhex( 1, 1, "#FF0000", 30, PD), 
image( 2, 2, [PA, PB, PC, PD], I), imageRotate90(I, I2).

En el ejemplo anterior “I” debería ser igual a “I2”

Si se hace imageFlipV dos veces de una imagen, debería resultar la imagen original:

pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), 
image( 2, 2, [PA, PB, PC, PD], I), imageFlipV(I, I2), imageFlipV(I2, I3).

En el ejemplo anterior “I” debería ser igual a “I3”

Si se hace imageFlipH dos veces de una imagen, debería resultar la imagen original:

pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), 
image( 2, 2, [PA, PB, PC, PD], I), imageFlipH(I, I2), imageFlipH(I2, I3).

En el ejemplo anterior “I” debería ser igual a “I3”

Si se hace imageFlipH a una imagen que tiene el mismo color y profundidad en todos sus pixeles, entonces la imagen resultante debería ser la misma imagen original.

pixhex( 0, 0, "#FF0000", 30, PA), pixhex( 0, 1, "#FF0000", 30, PB), pixhex( 1, 0, "#FF0000", 30, PC), pixhex( 1, 1, "#FF0000", 30, PD), 
image( 2, 2, [PA, PB, PC, PD], I), imageFlipH(I, I2).

En el ejemplo anterior “I” debería ser igual a “I2”

Se crea una imagen de 3x3 pixeles y se corta en una de 2x2 con solo la esquina inferior izquierda:

pixhex( 0, 0, "#FF0000", 20, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 0, 2, "#FF0000", 20, PC), 
pixhex( 1, 0, "#0000FF", 30, PD), pixhex( 1, 1, "#0000FF", 4, PE), pixhex( 1, 2, "#0000FF", 4, PF), 
pixhex( 2, 0, "#0000FF", 4, PG), pixhex( 2, 1, "#0000FF", 4, PH), pixhex( 2, 2, "#0000FF", 4, PI), image( 3, 3, [PA, PB, PC, PD, PE, PF, PG, PH, PI], I), 
imageCrop( I, 1, 1, 2, 2, I2), 

pixhex( 0, 0, "#0000FF", 4, PE2), pixhex( 0, 1, "#0000FF", 4, PF2), 
pixhex( 1, 0, "#0000FF", 4, PH2), pixhex( 1, 1, "#0000FF", 4, PI2), 
image( 2, 2, [PE2, PF2, PH2, PI2], I3).

En el ejemplo anterior, “I2” debería ser una imagen con los mismos pixeles y dimensiones que “I3”

Toma el píxel de la posición (0,1) que en la imagen original tiene los valores RGB (20, 20, 20) y lo reemplaza por otro píxel con valor RGB (54, 54, 54).

pixrgb( 0, 0, 10, 10, 10, 10, P1), pixrgb( 0, 1, 20, 20, 20, 20, P2), pixrgb( 1, 0, 30, 30, 30, 30, P3), pixrgb( 1, 1, 40, 40, 40, 40, P4), 
image( 2, 2, [P1, P2, P3, P4], I1), pixrgb( 0, 1, 54, 54, 54, 20, P2_modificado), imageChangePixel(I1, P2_modificado, I2).

Se construye imagen de 2x2 con los primeros 2 pixeles con profundidad 10 y los otros 2 con profundidad de 30, 
entonces al consultar “imageDepthLayers” se debería obtener una lista con dos imágenes.
   
pixrgb( 0, 0, 33, 33, 33, 10, PA), pixrgb( 0, 1, 44, 44, 44, 10, PB), pixrgb( 1, 0, 55, 55, 55, 30, PC), pixrgb( 1, 1, 66, 66, 66, 30, PD), 
image( 2, 2, [PA, PB, PC, PD], I), imageDepthLayers(I, [PRIMERA, SEGUNDA]), 

pixrgb( 0, 0, 33, 33, 33, 10, PA2), pixrgb( 0, 1, 44, 44, 44, 10, PB2), pixrgb( 1, 0, 255, 255, 255, 10, PC2), pixrgb( 1, 1, 255, 255, 255, 10, PD2), 
image( 2, 2, [PA2, PB2, PC2, PD2], I2), 

pixrgb( 0, 0, 255, 255, 255, 30, PA3), pixrgb( 0, 1, 255, 255, 255, 30, PB3), pixrgb( 1, 0, 55, 55, 55, 30, PC3), pixrgb( 1, 1, 66, 66, 66, 30, PD3), 
image( 2, 2, [PA3, PB3, PC3, PD3], I3).

En el ejemplo anterior, “I2” debería ser una imagen con los mismos pixeles y dimensiones que “PRIMERA”. 
“I3” debería ser una imagen con los mismos pixeles y dimensiones que “SEGUNDA”.

EJEMPLOS DE PRUEBA PROPIOS ----------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
Nota: algunos predicados como imageCompress y imageToString no tendran su espacio propio debido a que seran utilizados en otros predicados a modo de ejemplo


imageIsBitMap -----------------------------


pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(1,0,0,3,PB3), pixbit(1,1,1,4,PB4),
image(2,2,[PB1,PB2,PB3,PB4],IBit), imageIsBitmap(IBit). % Deberia dar true 

pixrgb(0,0,1,1,1,1,PRGB1), pixrgb(0,1,2,2,2,2,PRGB2), pixrgb(1,0,255,255,255,3,PRGB3), pixrgb(1,1,200,200,200,4,PRGB4),
image(2,2,[PRGB1,PRGB2,PRGB3,PRGB4],IRGB), imageIsBitmap(IRGB). % Deberia dar false 
 
pixhex(0,0,"#FF00FF",1,PH1), pixhex(0,1,"#F0000F",2,PH2),  pixhex(1,0,"#FFFFFF",3,PH3),  pixhex(1,1,"#000000",4,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],IHex), imageIsBitmap(IHex). % Deberia dar false 

imageIsPixMap -----------------------------


pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(1,0,0,3,PB3), pixbit(1,1,1,4,PB4),
image(2,2,[PB1,PB2,PB3,PB4],IBit), imageIsPixmap(IBit). % Deberia dar false 

pixrgb(0,0,1,1,1,1,PRGB1), pixrgb(0,1,2,2,2,2,PRGB2), pixrgb(1,0,255,255,255,3,PRGB3), pixrgb(1,1,200,200,200,4,PRGB4),
image(2,2,[PRGB1,PRGB2,PRGB3,PRGB4],IRGB), imageIsPixmap(IRGB). % Deberia dar true 


pixhex(0,0,"#FF00FF",1,PH1), pixhex(0,1,"#F0000F",2,PH2),  pixhex(1,0,"#FFFFFF",3,PH3),  pixhex(1,1,"#000000",4,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],IHex), imageIsPixmap(IHex). % Deberia dar false 


imageIsHexmap -----------------------------

pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(1,0,0,3,PB3), pixbit(1,1,1,4,PB4),
image(2,2,[PB1,PB2,PB3,PB4],IBit), imageIsHexmap(IBit). % Deberia dar false 

pixrgb(0,0,1,1,1,1,PRGB1), pixrgb(0,1,2,2,2,2,PRGB2), pixrgb(1,0,255,255,255,3,PRGB3), pixrgb(1,1,200,200,200,4,PRGB4),
image(2,2,[PRGB1,PRGB2,PRGB3,PRGB4],IRGB), imageIsHexmap(IRGB). % Deberia dar false 
 
pixhex(0,0,"#FF00FF",1,PH1), pixhex(0,1,"#F0000F",2,PH2),  pixhex(1,0,"#FFFFFF",3,PH3),  pixhex(1,1,"#000000",4,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],IHex), imageIsHexmap(IHex). % Deberia dar true 


imageIsCompressed --------------------------

pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(1,0,0,3,PB3), pixbit(1,1,1,4,PB4),
image(2,2,[PB1,PB2,PB3,PB4],IBit), imageIsCompressed(IBit). % Deberia dar false 

pixrgb(0,0,1,1,1,1,PRGB1), pixrgb(0,1,2,2,2,2,PRGB2), pixrgb(1,0,255,255,255,3,PRGB3), pixrgb(1,1,200,200,200,4,PRGB4),
image(2,2,[PRGB1,PRGB2,PRGB3,PRGB4],IRGB), imageCompress(IRGB,IRGB2), imageIsCompressed(IRGB2). % Deberia dar true 

pixhex(0,0,"#FF00FF",1,PH1), pixhex(0,1,"#F0000F",2,PH2),  pixhex(1,0,"#FFFFFF",3,PH3),  pixhex(1,1,"#000000",4,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],IHex), imageIsCompressed(IHex). % Deberia dar false 

FLIPH --------------------------------------

pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(1,0,0,3,PB3), pixbit(1,1,1,4,PB4),
image(2,2,[PB1,PB2,PB3,PB4],IBit), imageFlipH(IBit,IB2), imageFlipH(IB2,IB3). % IBit deberia ser igual a IB3

pixhex(0,0,"#FF00FF",1,PH1), pixhex(0,1,"#F0000F",2,PH2),  pixhex(1,0,"#FFFFFF",3,PH3),  pixhex(1,1,"#000000",4,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],IHex), imageFlipH(IHex,IH2), imageToString(IH2,I), write(I).

pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(0,2,0,3,PB3), pixbit(1,0,0,4,PB4), pixbit(1,1,1,5,PB5), pixbit(1,2,0,6,PB6),
image(3,2,[PB1,PB2,PB3,PB4,PB5,PB6],IBit2), imageFlipH(IBit2,I).

 FLIPV --------------------------------------

pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(1,0,0,3,PB3), pixbit(1,1,1,4,PB4),
image(2,2,[PB1,PB2,PB3,PB4],IBit), imageFlipV(IBit,IB2), imageFlipV(IB2,IB3). % IBit deberia ser igual a IB3

pixhex(0,0,"#FF00FF",1,PH1), pixhex(0,1,"#F0000F",2,PH2),  pixhex(1,0,"#FFFFFF",3,PH3),  pixhex(1,1,"#000000",4,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],IHex), imageFlipV(IHex,IH2), imageToString(IH2,I), write(I).

pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(0,2,0,3,PB3), pixbit(1,0,0,4,PB4), pixbit(1,1,1,5,PB5), pixbit(1,2,0,6,PB6),
image(3,2,[PB1,PB2,PB3,PB4,PB5,PB6],IBit2), imageFlipV(IBit2,I), imageToString(I,I2), write(I2).


Crop ----------------------------------------

pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(1,0,0,3,PB3), pixbit(1,1,1,4,PB4),
pixbit(0,0,0,3,PB5), pixbit(0,1,1,4,PB6),
image(2,2,[PB1,PB2,PB3,PB4],IBit), 
image(2,1,[PB5,PB6],IBit2),
imageCrop(IBit,0,1,1,1,I). % I = IBit2


pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(0,2,0,3,PB3), pixbit(1,0,0,4,PB4), pixbit(1,1,1,5,PB5), pixbit(1,2,0,6,PB6),
image(3,2,[PB1,PB2,PB3,PB4,PB5,PB6],I), imageCrop(I,0,0,1,0,I2), write(I2).


pixhex(0,0,"#FF00FF",1,PH1), pixhex(0,1,"#F0000F",2,PH2),  pixhex(1,0,"#FFFFFF",3,PH3),  pixhex(1,1,"#000000",4,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],IHex), imageFlipV(IHex,IH2), imageCrop(IH2,1,1,1,1,I), write(I).

imageRGBToHex -------------------------------

pixrgb(0,0,1,1,1,1,PRGB1), pixrgb(0,1,2,2,2,2,PRGB2), pixrgb(1,0,255,255,255,3,PRGB3), pixrgb(1,1,200,200,200,4,PRGB4),
image(2,2,[PRGB1,PRGB2,PRGB3,PRGB4],IRGB), imageRGBToHex(IRGB,I), imageToString(I,I2), write(I2).

pixhex(0,0,"#FFFFFF",1,PH1), pixhex(0,1,"#FFFFFF",2,PH2),  pixhex(1,0,"#FFFFFF",3,PH3),  pixhex(1,1,"#FFFFFF",4,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],IHex), 
pixrgb(0,0,255,255,255,1,P1), pixrgb(0,1,255,255,255,2,P2), pixrgb(1,0,255,255,255,3,P3), pixrgb(1,1,255,255,255,4,P4),
image(2,2,[P1,P2,P3,P4],I2), imageRGBToHex(I2,I3). % I3 = IHex


pixrgb(0,0,255,225,255,1,P1), pixrgb(0,1,1,1,1,2,P2), pixrgb(1,0,255,255,255,3,P3), pixrgb(1,1,0,0,0,4,P4),
image(2,2,[P1,P2,P3,P4],I), imageRGBToHex(I,I2), imageToString(I2,S), write(S).


histogram ---------------------------------

pixhex(0,0,"#FFFFFF",1,PH1), pixhex(0,1,"#FFFFFF",2,PH2),  pixhex(1,0,"#FFFFFF",3,PH3),  pixhex(1,1,"#FFFFFF",4,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],IHex), histogram(IHex,H).

pixrgb(0,0,255,225,255,1,P1), pixrgb(0,1,1,1,1,2,P2), pixrgb(1,0,255,255,255,3,P3), pixrgb(1,1,0,0,0,4,P4),
image(2,2,[P1,P2,P3,P4],I), imageRGBToHex(I,I2), histogram(I2,H).

pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(0,2,0,3,PB3), pixbit(1,0,0,4,PB4), pixbit(1,1,1,5,PB5), pixbit(1,2,0,6,PB6),
image(3,2,[PB1,PB2,PB3,PB4,PB5,PB6],IBit), histogram(IBit,H).

imageRotate90 ----------------------------------

pixhex(0,0,"#FFFFFF",1,PH1), pixhex(0,1,"#FFFFFF",2,PH2),  pixhex(1,0,"#FFFFFF",3,PH3),  pixhex(1,1,"#FFFFFF",4,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],I), imageRotate90(I,I2), imageRotate90(I2,I3), imageRotate90(I3,I4), imageRotate90(I4,I5). % I = I5


pixrgb(0,0,255,225,255,1,P1), pixrgb(0,1,1,1,1,2,P2), pixrgb(1,0,255,255,255,3,P3), pixrgb(1,1,0,0,0,4,P4),
image(2,2,[P1,P2,P3,P4],I), imageRotate90(I,I2), imageToString(I2,S), write(S).


pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(0,2,0,3,PB3), pixbit(1,0,0,4,PB4), pixbit(1,1,1,5,PB5), pixbit(1,2,0,6,PB6),
image(3,2,[PB1,PB2,PB3,PB4,PB5,PB6],I), imageRotate90(I,I2), imageToString(I2,S), write(S).


imageChangePixel ------------------------------


pixrgb(0,0,255,225,255,1,P1), pixrgb(0,1,1,1,1,2,P2), pixrgb(1,0,255,255,255,3,P3), pixrgb(1,1,0,0,0,4,P4),
image(2,2,[P1,P2,P3,P4],I), imageChangePixel(I,[0,1,2,2,2,2],I2), imageToString(I,S), imageToString(I2,S2),
write(S), write(S2).


pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(0,2,0,3,PB3), pixbit(1,0,0,4,PB4), pixbit(1,1,1,5,PB5), pixbit(1,2,0,6,PB6),
image(3,2,[PB1,PB2,PB3,PB4,PB5,PB6],I), imageChangePixel(I,[0,0,0,100],I2).


pixrgb(0,0,255,225,255,1,P1), pixrgb(0,1,1,1,1,2,P2), pixrgb(1,0,255,255,255,3,P3), pixrgb(1,1,0,0,0,4,P4),
image(2,2,[P1,P2,P3,P4],I), imageChangePixel(I,[0,1,2,2,2,2],I2), imageChangePixel(I,[0,1,100,100,100,2],I3), imageToString(I3,S3),write(S3).

imageInvertColorRGB ---------------------------

pixrgb(0,0,255,225,255,1,P1), pixrgb(0,1,1,1,1,2,P2), pixrgb(1,0,255,255,255,3,P3), pixrgb(1,1,0,0,0,4,P4),
image(2,2,[P1,P2,P3,P4],I), imageInvertColorRGB(I,I2).

pixrgb(0,0,255,225,255,1,P1), pixrgb(0,1,1,1,1,2,P2), pixrgb(1,0,255,255,255,3,P3), pixrgb(1,1,0,0,0,4,P4),
image(2,2,[P1,P2,P3,P4],I), imageInvertColorRGB(I,I2), imageInvertColorRGB(I2,I3). % I3 = I



pixrgb(0,0,1,1,1,1,PRGB1), pixrgb(0,1,2,2,2,2,PRGB2), pixrgb(1,0,255,255,255,3,PRGB3), pixrgb(1,1,200,200,200,4,PRGB4),
image(2,2,[PRGB1,PRGB2,PRGB3,PRGB4],I), imageInvertColorRGB(I,I2), imageInvertColorRGB(I2,I3), imageInvertColorRGB(I3,I4). % I4 = I2, I3 = I

imageDepthLayers --------------------------------

pixrgb(0,0,255,225,255,1,P1), pixrgb(0,1,1,1,1,2,P2), pixrgb(1,0,255,255,255,3,P3), pixrgb(1,1,0,0,0,4,P4),
image(2,2,[P1,P2,P3,P4],I), imageDepthLayers(I,D). % D = lista de 4 imagenes


pixbit(0,0,1,1,PB1), pixbit(0,1,0,1,PB2), pixbit(0,2,0,3,PB3), pixbit(1,0,0,1,PB4), pixbit(1,1,1,5,PB5), pixbit(1,2,0,6,PB6),
image(3,2,[PB1,PB2,PB3,PB4,PB5,PB6],I), imageDepthLayers(I,D). % Lista de 4 imagenes


pixhex(0,0,"#FF00FFF",1,PH1), pixhex(0,1,"#00FFFF",1,PH2),  pixhex(1,0,"#FFFF00",1,PH3),  pixhex(1,1,"#EEEEEE",2,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],I), imageDepthLayers(I,D). % Lista de 2 imagenes

imageDecompress ----------------------------------

pixrgb(0,0,1,1,1,1,PRGB1), pixrgb(0,1,2,2,2,2,PRGB2), pixrgb(1,0,255,255,255,3,PRGB3), pixrgb(1,1,200,200,200,4,PRGB4),
image(2,2,[PRGB1,PRGB2,PRGB3,PRGB4],I), imageCompress(I,I2), imageDecompress(I2,I3). % I = I3

pixbit(0,0,1,1,PB1), pixbit(0,1,0,2,PB2), pixbit(0,2,0,3,PB3), pixbit(1,0,0,4,PB4), pixbit(1,1,1,5,PB5), pixbit(1,2,0,6,PB6),
image(3,2,[PB1,PB2,PB3,PB4,PB5,PB6],I), imageCompress(I,I2), imageCompress(I2,I3), imageDecompress(I3,I4). % I2 = I4

pixhex(0,0,"#FF00FFF",1,PH1), pixhex(0,1,"#00FFFF",1,PH2),  pixhex(1,0,"#FFFF00",1,PH3),  pixhex(1,1,"#EEEEEE",2,PH4), 
image(2,2,[PH1,PH2,PH3,PH4],I), imageDecompress(I,I2). 
% Deberia dar false ya que I no esta comprimida

*/
