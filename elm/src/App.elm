module App exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Projects exposing (Project)
import Strings exposing (Lang(..))


type alias Model =
    { lang : Strings.Lang
    , projects : List Project
    , expandedProject : Maybe Int
    }


type Msg
    = SwitchLang
    | GotProjects (Result Http.Error (List Project))


main : Program () Model Msg
main =
    Browser.document
        { init = \_ -> init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : ( Model, Cmd Msg )
init =
    -- let
    --     lang =
    -- in
    ( { lang = German, projects = [], expandedProject = Nothing }, Projects.getProjects GotProjects )


view : Model -> Browser.Document Msg
view model =
    let
        all =
            Strings.all model.lang
    in
    { title = "Filippo Orru"
    , body =
        [ div [ class "header" ]
            [ h1 [ class "header-name" ] [ text "Filippo Orru" ]
            , h2 [ class "header-text" ] [ text all.headerText ]
            , button [ class "switch-lang-btn", onClick SwitchLang ] [ text all.switchLangBtn ]
            ]
        , div [ class "body-wrapper" ]
            [ div [ class "body" ]
                (Projects.view
                    model.projects
                    model.lang
                    model.expandedProject
                )
            ]
        ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SwitchLang ->
            ( { model
                | lang =
                    case model.lang of
                        German ->
                            English

                        English ->
                            German
              }
            , Cmd.none
            )

        GotProjects res ->
            case res of
                Ok projects ->
                    let
                        _ =
                            Debug.log "Got projects" projects
                    in
                    ( { model | projects = projects }, Cmd.none )

                Err e ->
                    let
                        _ =
                            Debug.log "err" e
                    in
                    ( model, Cmd.none )
