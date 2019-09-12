{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "my-project"
, dependencies =
    [ "aff"
    , "arrays"
    , "console"
    , "effect"
    , "foreign"
    , "halogen"
    , "identity"
    , "integers"
    , "lists"
    , "math"
    , "numbers"
    , "prelude"
    , "proxy"
    , "psci-support"
    , "purescript-easy-ffi"
    , "purescript-mochi"
    , "purescript-three"
    , "record"
    , "refs"
    , "transformers"
    , "tuples"
    , "typelevel-prelude"
    , "web-dom"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
