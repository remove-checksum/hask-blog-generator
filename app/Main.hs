import Html
import MyLib (someFunc)

main :: IO ()
main = do
  let document =
        render $
          html_ "thetitle" $
            append_ (p_ "doba") (h1_ "hoba")
  writeFile "./index.html" document
