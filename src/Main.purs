module Main where

import Prelude

import Affjax as AX
import Affjax.ResponseFormat as ResponseFormat
import Data.Argonaut (Json, JsonDecodeError, decodeJson, printJsonDecodeError)
import Data.Either (Either(..))
import Data.HTTP.Method (Method(..))
import Data.List (List)
import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class.Console (log)

url :: String
url = "https://api.github.com/repos/jacob-alford/authorship/contents/the-duncan-strauss-mysteries"

type BlogResponse = List {
  name :: String,
  path :: String,
  sha :: String,
  size :: Int,
  url :: String,
  html_url :: String,
  git_url :: String,
  download_url :: String
}

decodeResult :: Json -> Either JsonDecodeError BlogResponse
decodeResult = decodeJson

main :: Effect Unit
main = void $ launchAff $ do
  result <- AX.request (AX.defaultRequest { url = url, method = Left GET, responseFormat = ResponseFormat.json })
  case result of 
    Left err -> log $ "Request failed: " <> AX.printError err
    Right undecodedResponse -> case decodeResult undecodedResponse.body of
      Left decodeErr -> log $ "Failed to decode response: " <> printJsonDecodeError decodeErr
      Right response -> log $ show response