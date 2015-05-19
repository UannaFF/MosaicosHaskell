module Main (main) where

import System.Environment  (getArgs, getProgName)
import Graphics.Mosaico.Diagrama (Diagrama((:-:), (:|:), Hoja), Paso(Primero, Segundo))
import Graphics.Mosaico.Imagen
import Graphics.Mosaico.Ventana  (Ventana, cerrar, crearVentana, leerTecla, mostrar)

import Diagramas (Orientación(Horizontal, Vertical), caminar, dividir, rectánguloImagen, sustituir)

ciclo :: Ventana -> Diagrama -> [Paso] -> IO ()
ciclo = undefined

-- Para tomar los datos del IO de leerImagen
getImagen :: Either String Imagen -> Imagen
getImagen (Right (Imagen an al datos)) = Imagen an al datos

main :: IO ()
main = do
	args <- getArgs
	case args of
		(filename:_) -> do
			results <- (leerImagen filename)
			let imagen = getImagen results
			let rectan = rectánguloImagen imagen
			print rectan