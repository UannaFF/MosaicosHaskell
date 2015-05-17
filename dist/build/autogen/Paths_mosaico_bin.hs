module Paths_mosaico_bin (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/anigarden/Documents/Mosaicos-Haskell/mosaico-bin/.cabal-sandbox/bin"
libdir     = "/home/anigarden/Documents/Mosaicos-Haskell/mosaico-bin/.cabal-sandbox/lib/x86_64-linux-ghc-7.8.4/mosaico-bin-0.1.0.0"
datadir    = "/home/anigarden/Documents/Mosaicos-Haskell/mosaico-bin/.cabal-sandbox/share/x86_64-linux-ghc-7.8.4/mosaico-bin-0.1.0.0"
libexecdir = "/home/anigarden/Documents/Mosaicos-Haskell/mosaico-bin/.cabal-sandbox/libexec"
sysconfdir = "/home/anigarden/Documents/Mosaicos-Haskell/mosaico-bin/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "mosaico_bin_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "mosaico_bin_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "mosaico_bin_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "mosaico_bin_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "mosaico_bin_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
