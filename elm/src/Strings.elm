module Strings exposing (All, Lang(..), all, project)


type Lang
    = German
    | English


type alias All =
    { headerText : String
    , switchLangBtn : String
    , introduction : String
    , aboutMe : String
    }


all : Lang -> All
all lang =
    { headerText = headerText lang
    , switchLangBtn = switchLangBtn lang
    , introduction = introduction lang
    , aboutMe = aboutMe lang
    }


type alias ProjectStrings =
    { collapse : String
    , expand : String
    }


project : Lang -> ProjectStrings
project lang =
    { collapse = projectCollapse lang
    , expand = projectExpand lang
    }


projectCollapse lang =
    case lang of
        German ->
            "Schließen"

        English ->
            "Close"


projectExpand lang =
    case lang of
        German ->
            "Details"

        English ->
            "Read more"


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


aboutMe : Lang -> String
aboutMe lang =
    case lang of
        German ->
            """Ich bin 18 Jahre alt und studiere Informatik in Graz.
            In meiner Freizeit arbeite ich gern an kleinen Hobbyprojekten."""

        English ->
            """I'm an 18 year old computer science student living in Graz.
            In my free time, I like working on my own programming projects."""
