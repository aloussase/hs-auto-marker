module Auth
(
  doLogin
)
where

import           Control.Monad.IO.Class   (liftIO)
import           Data.Text                (Text)
import qualified Data.Text                as T
import           System.Environment.Blank (getEnv)
import           Test.WebDriver

type Credentials = (Text, Text)

mkCredentials :: IO Credentials
mkCredentials = do
  Just username <- fmap T.pack <$> getEnv "ESPOLUSER"
  Just password <- fmap T.pack <$> getEnv "ESPOLPSWD"
  pure $ (username, password)

doLogin :: WD ()
doLogin = do
  (username, password) <- liftIO mkCredentials

  usernameInput <- findElem $ ById "username"
  passwordInput <- findElem $ ById "password"

  sendKeys username usernameInput
  sendKeys password passwordInput

  submit usernameInput
