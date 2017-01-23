module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Routing
import View exposing (view)
import Update exposing (update)
import Subscriptions exposing (subscriptions)

import Navigation exposing (Location)

main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

init : Location -> (Model, Cmd Msg)
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        (initialModel currentRoute, Cmd.none)
