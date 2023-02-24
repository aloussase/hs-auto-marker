{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Auth                   (doLogin)

import           Control.Monad.Catch    (handleAll)
import           Control.Monad.IO.Class (liftIO)
import           Test.WebDriver

chromeConfig :: WDConfig
chromeConfig = useBrowser chrome defaultConfig

main :: IO ()
main = runSession chromeConfig $
  handleAll handler $ do
    openPage "http://ayudantias.espol.edu.ec"
    doLogin
  where
    handler ex = liftIO (print ex) >> closeSession

