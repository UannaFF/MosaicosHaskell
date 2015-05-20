module
  Diagramas
  ( rectánguloImagen
  , Orientación(Horizontal, Vertical)
  , dividir
  , caminar
  , sustituir
  )
  where

import Graphics.Mosaico.Diagrama (Diagrama((:-:), (:|:), Hoja), Paso(Primero, Segundo), Rectángulo(Rectángulo, color, imagen))
import Graphics.Mosaico.Imagen   (Imagen(Imagen, altura, anchura, datos), Color(Color, rojo, verde, azul))

import Imagen (colorPromedio, hSplit, vSplit)


rectánguloImagen :: Imagen -> Rectángulo
rectánguloImagen imagen = Rectángulo (colorPromedio imagen) imagen

data Orientación
  = Horizontal
  | Vertical
  deriving Show

dividir :: Orientación -> Rectángulo -> Maybe Diagrama
dividir o (Rectángulo _ (Imagen anch alt dat)) = case o of
                                              Horizontal -> if alt < 2 then Nothing else 
                                                            Just ((Hoja (rectánguloImagen (fst split))) :-: (Hoja (rectánguloImagen (snd split))))
                                                            where split = hSplit (Imagen anch alt dat)
                                              Vertical -> if anch < 2 then Nothing else
                                                            Just ((Hoja (rectánguloImagen (fst split))) :|: (Hoja (rectánguloImagen (snd split))))
                                                            where split = vSplit (Imagen anch alt dat)

caminar :: [Paso] -> Diagrama -> Maybe Diagrama
caminar (pas:pasos) diagramis = case pas of
                                  Primero -> case diagramis of
                                                Hoja _ -> Nothing
                                                diagP :-: _ -> caminar pasos diagP
                                                diagP :|: _ -> caminar pasos diagP
                                  Segundo -> case diagramis of
                                                Hoja _ -> Nothing
                                                _ :-: diagS -> caminar pasos diagS
                                                _ :|: diagS -> caminar pasos diagS
caminar [] diagramis = Just diagramis

sustituir :: Diagrama -> [Paso] -> Diagrama -> Diagrama
sustituir diag1 (paso:pasos) diag2 = case paso of
                                      Primero -> case diag2 of
                                                Hoja _ -> diag2
                                                diagP :-: diagS -> (sustituir diag1 pasos diagP) :-: diagS
                                                diagP :|: diagS -> (sustituir diag1 pasos diagP) :|: diagS
                                      Segundo -> case diag2 of
                                                Hoja _ -> diag2
                                                diagP :-: diagS -> diagP :-: (sustituir diag1 pasos diagS)
                                                diagP :|: diagS -> diagP :|: (sustituir diag1 pasos diagS)
sustituir diag1 [] diag2 = diag1
