module Projects exposing (LocalizedPart, LocalizedProject, Project, decodeProjects, getProjects, view)

import Array exposing (Array)
import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as D exposing (Decoder, field)
import Strings


type alias LocalizedProject =
    { name : String
    , visible : Bool
    , local : LocalizedPart
    , images : Array String
    , date : String
    }


type alias Project =
    { name : String
    , visible : Bool
    , local : UnlocalizedParts
    , images : Array String
    , date : String
    }


type alias UnlocalizedParts =
    { en : LocalizedPart
    , de : LocalizedPart
    }


type alias LocalizedPart =
    { desc : String
    , desc_long : String
    }


view : List Project -> Strings.Lang -> Maybe Int -> List (Html msg)
view projects lang maybeselected =
    let
        open_index =
            case maybeselected of
                Just i ->
                    i

                Nothing ->
                    -1
    in
    [ div [ class "projects" ] <|
        -- (List.map (translateProject lang) projects
        List.indexedMap (viewProject open_index lang) projects

    -- )
    ]


localizeProject : Strings.Lang -> Project -> LocalizedProject
localizeProject lang p =
    let
        local =
            case lang of
                Strings.English ->
                    p.local.en

                Strings.German ->
                    p.local.de
    in
    { name = p.name
    , visible = p.visible
    , local = local
    , images = p.images
    , date = p.date
    }


viewProject : Int -> Strings.Lang -> Int -> Project -> Html msg
viewProject expanded_index lang my_index project =
    let
        localProject =
            localizeProject lang project

        expanded =
            expanded_index == my_index

        pClass =
            if expanded then
                "project expanded"

            else
                "project"

        imgMissing =
            "/img/image_missing.png"

        imgPath =
            case Array.get 0 project.images of
                Just s ->
                    s

                Nothing ->
                    imgMissing

        btnText =
            if expanded then
                "collapse"

            else
                "expand"
    in
    if project.visible then
        div [ class pClass ]
            [ img [ class "project-cover", src imgPath ] []
            , hr [ class "vertical" ] []
            , div [ class "project-body" ]
                [ h3 [] [ text localProject.name ]
                , p [] [ text localProject.local.desc ]
                , button [ class "expand-btn" ] [ text btnText ]
                ]
            ]

    else
        text ""


getProjects : (Result Http.Error (List Project) -> msg) -> Cmd msg
getProjects msg =
    Http.get { url = "/projects.json", expect = Http.expectJson msg decodeProjects }


decodeProjects : Decoder (List Project)
decodeProjects =
    D.list decodeProject


decodeProject : Decoder Project
decodeProject =
    D.map5 Project
        (D.field "name" D.string)
        (D.field "visible" D.bool)
        (D.field "local" decodeUnlocalized)
        (D.field "images" (D.array D.string))
        (D.field "date" D.string)


decodeUnlocalized : Decoder UnlocalizedParts
decodeUnlocalized =
    D.map2 UnlocalizedParts
        (D.field "en" decodeLocalized)
        (D.field "de" decodeLocalized)


decodeLocalized : Decoder LocalizedPart
decodeLocalized =
    D.map2 LocalizedPart
        (D.field "desc" D.string)
        (D.field "desc_long" D.string)



-- getProjectsu : Strings.Lang -> List LocalizedProject
-- getProjectsu lang =
--     let
--         u =
--             ""
--     in
--     [ { name = "lol", visible = True, local = { desc = "desc", long_desc = "lololo" } } ]
