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
    , "integers"
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
