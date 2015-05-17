module Imagen
  ( hSplit, vSplit
  , colorPromedio
  )
  where

import Graphics.Mosaico.Imagen (Color(Color, rojo, verde, azul), Imagen(Imagen, altura, anchura, datos),leerImagen)



subImagen
  :: Integer -> Integer
  -> Integer -> Integer
  -> Imagen -> Imagen

subImagen = undefined



hSplit :: Imagen -> (Imagen, Imagen)
hSplit = undefined

vSplit :: Imagen -> (Imagen, Imagen)
vSplit = undefined

colorPromedio :: Imagen -> Color
colorPromedio = undefined
