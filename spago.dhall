{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "my-project"
, dependencies =
    [ "arrays"
    , "console"
    , "effect"
    , "foreign"
    , "halogen"
    , "math"
    , "prelude"
    , "psci-support"
    , "purescript-easy-ffi"
    , "purescript-three"
    , "refs"
    , "transformers"
    , "tuples"
    , "web-dom"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
