{-

This file is part of the package devalot-hakyll. It is subject to the
license terms in the LICENSE file found in the top-level directory of
this distribution and at git://pmade.com/devalot-hakyll/LICENSE.  No
part of devalot-hakyll package, including this file, may be copied,
modified, propagated, or distributed except according to the terms
contained in the LICENSE file.

-}

--------------------------------------------------------------------------------
module Hakyll.Web.Sass (sassCompiler , scssCompiler) where

--------------------------------------------------------------------------------
import Hakyll.Core.Compiler (Compiler, getResourceString, makeItem)
import Hakyll.Core.Item (Item, itemBody)
import Hakyll.Core.UnixFilter (unixFilter)
import Hakyll.Web.CompressCss (compressCss)

--------------------------------------------------------------------------------
-- | Convert a @*.sass@ file into compressed CSS.
sassCompiler :: Compiler (Item String)
sassCompiler = toCSS "sass"

--------------------------------------------------------------------------------
-- | Convert a @*.scss@ file into compress CSS.
scssCompiler :: Compiler (Item String)
scssCompiler = toCSS "scss"

--------------------------------------------------------------------------------
toCSS :: String -> Compiler (Item String)
toCSS tool = do item <- getResourceString
                css  <- unixFilter tool options $ itemBody item
                makeItem $ compressCss css
  where options = ["-s", "--trace"]
