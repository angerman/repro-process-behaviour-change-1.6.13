module Main where

import           System.IO.Error (ioeGetErrorType, isDoesNotExistErrorType)
import           System.Process (readProcessWithExitCode)
import           System.Exit
import           Control.Exception (handleJust)

runGitRevParse :: IO String
runGitRevParse = handleJust missingGit (const $ pure "<no git executable found>") $ do
  (exitCode, output, _) <-
    readProcessWithExitCode "git" ["rev-parse", "--verify", "HEAD"] ""
  pure $ case exitCode of
    ExitSuccess -> output
    _           -> ""

missingGit e = if isDoesNotExistErrorType (ioeGetErrorType e) then Just () else Nothing

main :: IO ()
main = runGitRevParse >>= putStrLn
