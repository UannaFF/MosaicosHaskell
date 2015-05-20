module Main (main) where

import System.Environment  (getArgs, getProgName)
import Graphics.Mosaico.Diagrama (Diagrama((:-:), (:|:), Hoja), Paso(Primero, Segundo))
import Graphics.Mosaico.Imagen
import Graphics.Mosaico.Ventana  (Ventana, cerrar, crearVentana, leerTecla, mostrar)

import Diagramas (Orientación(Horizontal, Vertical), caminar, dividir, rectánguloImagen, sustituir)
import Imagen

ciclo :: Ventana -> Diagrama -> [Paso] -> IO ()
ciclo ventana diagrama pasos = do
								let diag_caminado = case (caminar pasos diagrama) of
														Just new_diag -> new_diag
														Nothing -> diagrama
								nueva_ventana <- (mostrar ventana pasos diagrama)
								tecla <- (leerTecla ventana)
								case tecla of
									Nothing -> ciclo ventana diagrama pasos
									Just s -> case s of
												"q" -> cerrar ventana
												"BackSpace" -> if (null pasos) then ciclo ventana diagrama pasos
																else ciclo ventana diagrama (init pasos)
												"Left" -> case diag_caminado of
															Hoja hojita -> do 
																case dividendo of
																	Just new_diag -> ciclo ventana (sustituir new_diag pasos diagrama) (pasos++[Primero])
																	Nothing -> ciclo ventana diagrama pasos
																	where 
																		dividendo = dividir Vertical hojita
															a :|: b -> ciclo ventana diagrama (pasos++[Primero])
															_ -> ciclo ventana diagrama pasos
												"Right" -> case diag_caminado of
															Hoja hojita -> do 
																case dividendo of
																	Just new_diag -> ciclo ventana (sustituir new_diag pasos diagrama) (pasos++[Segundo])
																	Nothing -> ciclo ventana diagrama pasos
																	where 
																		dividendo = dividir Vertical hojita
															a :|: b -> ciclo ventana diagrama (pasos++[Segundo])
															_ -> ciclo ventana diagrama pasos
												"Up" -> case diag_caminado of
															Hoja hojita -> do 
																case dividendo of
																	Just new_diag -> ciclo ventana (sustituir new_diag pasos diagrama) (pasos++[Primero])
																	Nothing -> ciclo ventana diagrama pasos
																	where 
																		dividendo = dividir Horizontal hojita
															a :-: b -> ciclo ventana diagrama (pasos++[Primero])
															_ -> ciclo ventana diagrama pasos
												"Down" -> case diag_caminado of
															Hoja hojita -> do 
																case dividendo of
																	Just new_diag -> ciclo ventana (sustituir new_diag pasos diagrama) (pasos++[Segundo])
																	Nothing -> ciclo ventana diagrama pasos
																	where 
																		dividendo = dividir Horizontal hojita
															a :-: b -> ciclo ventana diagrama (pasos++[Segundo])
															_ -> ciclo ventana diagrama pasos
												_ -> ciclo ventana diagrama pasos

-- Para tomar los datos del IO de leerImagen
getImagen :: Either String Imagen -> Maybe Imagen
getImagen (Right (Imagen an al datos)) = Just (Imagen an al datos)
getImagen (Left _) =  Nothing

getAnchura :: Imagen -> Integer
getAnchura (Imagen an al d) = an
getAltura :: Imagen -> Integer
getAltura (Imagen an al d) = al

pegate x = pegate x

main :: IO ()
main = do
	args <- getArgs
	case args of
		(filename:[]) -> do
			results <- (leerImagen filename)
			case (getImagen results) of
				Just i -> do
							let imagen = i
							let rect = rectánguloImagen imagen
							ventana <- (crearVentana (getAnchura imagen) (getAltura imagen))
							ciclo ventana (Hoja rect) []
				Nothing -> print "El archivo especificado no existe."
		[] -> do
			print "No se especifico ninguna imagen."
		_ -> do
			print "Se tiene que pasar exactamente un parametro -> direccion a una foto"
