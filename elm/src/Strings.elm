module Strings exposing (Lang(..), all)


type Lang
    = German
    | English


type alias All =
    { headerText : String
    , switchLangBtn : String
    , introduction : String
    }


all : Lang -> All
all lang =
    { headerText = headerText lang
    , switchLangBtn = switchLangBtn lang
    , introduction = introduction lang
    }


headerText : Lang -> String
headerText lang =
    case lang of
        German ->
            "Persönliche Websites und Onlineshops für Kleinunternehmen und Privatpersonen"

        English ->
            "Personal Websites and Online Shops for small businesses and individuals"


switchLangBtn : Lang -> String
switchLangBtn lang =
    case lang of
        German ->
            "English"

        English ->
            "Deutsch"


introduction : Lang -> String
introduction lang =
    case lang of
        German ->
            "Introduktion!"

        English ->
            "Intro"
