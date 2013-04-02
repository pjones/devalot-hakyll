{-

This file is part of the package devalot-hakyll. It is subject to the
license terms in the LICENSE file found in the top-level directory of
this distribution and at git://pmade.com/devalot-hakyll/LICENSE.  No
part of devalot-hakyll package, including this file, may be copied,
modified, propagated, or distributed except according to the terms
contained in the LICENSE file.

-}

--------------------------------------------------------------------------------
module Hakyll.Web.JavaScript (jsCompiler, jsCreate) where

--------------------------------------------------------------------------------
import Control.Applicative ((<$>))
import Data.ByteString.Lazy.UTF8 (toString)
import Data.List (intercalate)
import Hakyll
import Text.Jasmine (minify)

--------------------------------------------------------------------------------
-- | Compile a JavaScript file by minimizing it.
jsCompiler :: Compiler (Item String)
jsCompiler = fmap (toString . minify) <$> getResourceLBS

--------------------------------------------------------------------------------
-- | Compile all matching JavaScript files into a single file.
jsCreate :: Identifier -- ^ The name of the output file to create.
         -> Pattern    -- ^ A pattern to match all of the input files.
         -> Rules ()   -- ^ Rules for Hakyll.
jsCreate file pattern = do
    match pattern $ compile jsCompiler
    create [file] $ do
      route idRoute
      compile $ do
        files <- (loadAll pattern' :: Compiler [Item String])
        makeItem $ intercalate ";\n" $ map itemBody files
  where pattern' = pattern .&&. complement (fromList [file])
