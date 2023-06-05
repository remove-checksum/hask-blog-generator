module Html (html_, append_, h1_, p_, render) where

newtype Html = Html String

newtype Structure = Structure String

type Tag = String

type Title = String

type Content = String

render :: Html -> String
render (Html a) = a

html_ :: Title -> Structure -> Html
html_ title (Structure content) =
  Html
    $ el
      "html"
    $ el
      "head"
      ( el
          "title"
          $ escape title
      )
      <> el "body" (escape content)

getStructureString :: Structure -> String
getStructureString (Structure a) = a

el :: String -> String -> String
el tag content = open <> content <> close
  where
    open = "<" <> tag <> ">"
    close = "</" <> tag <> ">"

body_ :: String -> Structure
body_ = Structure . el "body" . escape

head_ :: String -> Structure
head_ = Structure . el "head" . escape

title_ :: String -> Structure
title_ = Structure . el "title" . escape

p_ :: String -> Structure
p_ = Structure . el "p" . escape

h1_ :: String -> Structure
h1_ = Structure . el "h1" . escape

append_ :: Structure -> Structure -> Structure
append_ (Structure a) (Structure b) = Structure $ a <> b

escape :: String -> String
escape =
  let escapeChar c =
        case c of
          '<' -> "&lt;"
          '>' -> "&gt;"
          '&' -> "&amp;"
          '"' -> "&quot;"
          '\'' -> "&#39;"
          _ -> [c]
   in concatMap escapeChar