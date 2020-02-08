module Projects exposing (..)

import Html exposing (..)
import Http
import Json.Decode as D exposing (Decoder, field)
import Strings


type alias LocalizedProject =
    { name : String
    , visible : Bool
    , local : LocalizedPart
    }


type alias Project =
    { name : String
    , visible : Bool
    , local :
        { en : LocalizedPart
        , de : LocalizedPart
        }
    }


type alias LocalizedPart =
    { desc : String
    , long_desc : String
    }


view : Maybe Int -> List (Html msg)
view model =
    [ div [] [ text "lol" ] ]


getProjects : (Result Http.Error String -> msg) -> Strings.Lang -> Cmd msg
getProjects msg lang =
    Http.get { url = "/projects.json", expect = Http.expectJson msg (projectsDecoder lang) }


projectsDecoder : Strings.Lang -> Decoder String
projectsDecoder lang =
    D.field "name" D.string


getProjectsu : Strings.Lang -> List LocalizedProject
getProjectsu lang =
    let
        u =
            ""
    in
    [ { name = "lol", visible = True, local = { desc = "desc", long_desc = "lololo" } } ]
