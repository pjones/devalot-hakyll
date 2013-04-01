{-

This file is part of the package devalot-hakyll. It is subject to the
license terms in the LICENSE file found in the top-level directory of
this distribution and at git://pmade.com/devalot-hakyll/LICENSE.  No
part of devalot-hakyll package, including this file, may be copied,
modified, propagated, or distributed except according to the terms
contained in the LICENSE file.

-}

--------------------------------------------------------------------------------
module Hakyll.Web.JavaScript (jsCompiler) where

--------------------------------------------------------------------------------
import Control.Applicative ((<$>))
import Data.ByteString.Lazy.UTF8 (toString)
import Hakyll.Core.Compiler (Compiler, getResourceLBS)
import Hakyll.Core.Item (Item)
import Text.Jasmine (minify)

--------------------------------------------------------------------------------
-- | Compile a JavaScript file by minimizing it.
jsCompiler :: Compiler (Item String)
jsCompiler = fmap (toString . minify) <$> getResourceLBS
