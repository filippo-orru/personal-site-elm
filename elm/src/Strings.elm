module Strings exposing (All, Lang(..), all, projectStrings)


type Lang
    = German
    | English


type alias All =
    { head : HeadStrings
    , aboutMe : AboutMeStrings
    , project : ProjectStrings
    }


all : Lang -> All
all lang =
    { head = headStrings lang
    , aboutMe = aboutMeStrings lang
    , project = projectStrings lang
    }


type alias HeadStrings =
    { text : String
    , switchLangBtn : String
    }


headStrings : Lang -> HeadStrings
headStrings lang =
    let
        ( text, switchLangBtn ) =
            case lang of
                German ->
                    ( "Persönliche Websites und Onlineshops für Kleinunternehmen und Privatpersonen", "English" )

                English ->
                    ( "Personal Websites and Online Shops for small businesses and individuals", "Deutsch" )
    in
    { text = text
    , switchLangBtn = switchLangBtn
    }


type alias AboutMeStrings =
    { title : String
    , body : String
    }


aboutMeStrings : Lang -> AboutMeStrings
aboutMeStrings lang =
    let
        title =
            case lang of
                German ->
                    "Über mich"

                English ->
                    "About me"
    in
    { title = title
    , body = aboutMe lang
    }


aboutMe : Lang -> String
aboutMe lang =
    case lang of
        German ->
            """Ich bin 18 Jahre alt und studiere Informatik in Graz.
            In meiner Freizeit arbeite ich gern an kleinen Hobbyprojekten."""

        English ->
            """I'm an 18 year old computer science student living in Graz.
            In my free time, I like working on my own programming projects."""


type alias ProjectStrings =
    { title : String
    , collapse : String
    , expand : String
    }


projectStrings : Lang -> ProjectStrings
projectStrings lang =
    let
        ( title, collapse, expand ) =
            case lang of
                German ->
                    ( "Projekte", "Schließen", "Details" )

                English ->
                    ( "Projects", "Close", "Read more" )
    in
    { title = title
    , collapse = collapse
    , expand = expand
    }
