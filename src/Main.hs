module Main (main) where

import System.Environment  (getArgs, getProgName)
import Graphics.Mosaico.Diagrama (Diagrama((:-:), (:|:), Hoja), Paso(Primero, Segundo))
import Graphics.Mosaico.Imagen
import Graphics.Mosaico.Ventana  (Ventana, cerrar, crearVentana, leerTecla, mostrar)

import Diagramas (Orientación(Horizontal, Vertical), caminar, dividir, rectánguloImagen, sustituir)
import Imagen

ciclo :: Ventana -> Diagrama -> [Paso] -> IO ()
ciclo = undefined

-- Para tomar los datos del IO de leerImagen
getImagen :: Either String Imagen -> Imagen
getImagen (Right (Imagen an al datos)) = Imagen an al datos
getImagen (Left _) =  Imagen 1 1 [[Color {rojo = 0, verde = 0, azul = 0}]]

main :: IO ()
main = do
	args <- getArgs
	case args of
		(filename:_) -> do
			results <- (leerImagen filename)
			let imagen = getImagen results
			print imagen
			let h = hSplit imagen
			let top = hSplit (fst h)
			print "Color primera fila:"
			--print colorPromedio (fst top)
			print "Deberia ser 66, 76, 109"
			print "Color segunda fila:"
			let rect = rectánguloImagen imagen
			let diag = dividir Vertical rect
			case diag of
				Just di -> do 
							let diag2 = (caminar [Primero] di)
							print diag2
				Nothing -> print "Nothing"
			--print colorPromedio (snd top)
		[] -> do
			print "No se especifico imagen"
