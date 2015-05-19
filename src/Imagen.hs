module Imagen
  ( hSplit, vSplit
  , colorPromedio
  )
  where

import Graphics.Mosaico.Imagen (Color(Color, rojo, verde, azul), Imagen(Imagen, altura, anchura, datos),leerImagen)


corteVertical :: [[Color]] -> Integer -> Integer -> [[Color]]
corteVertical c inicio fin = take (fromIntegral fin) (drop (fromIntegral inicio) c) 

corteHorizontal :: [[Color]] -> Integer -> Integer -> [[Color]]
corteHorizontal c inicio fin = [ take (fromIntegral fin) (drop (fromIntegral inicio) f) |  f <- c ]

subImagen
  :: Integer -> Integer
  -> Integer -> Integer
  -> Imagen -> Imagen

subImagen xInicial yInicial anchura' altura' imagen@(Imagen an al datos) = Imagen anchura' altura' corte
	where corte = corteVertical corteH yInicial altura'
		where corteH = corteHorizontal datos xInicial anchura' 


hSplit :: Imagen -> (Imagen, Imagen)
hSplit img@(Imagen an al datos) = (subImagen 0 0 an (half al) img, subImagen 0 (half al) an (div al 2) img)
	where half x = if even x then div x 2 else (div x 2) + 1

vSplit :: Imagen -> (Imagen, Imagen)
vSplit img@(Imagen an al datos) = (subImagen 0 0 (half an) al img, subImagen (half an) 0 (div an 2) al img)
	where half x = if even x then div x 2 else (div x 2) + 1

colorPromedio :: Imagen -> Color
colorPromedio (Imagen an al c) = Color {rojo = 0, verde = 0, azul = 0} 
