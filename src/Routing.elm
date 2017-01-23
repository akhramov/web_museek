module Routing exposing (..)

import Transfers.Models exposing (Transfer)
import Navigation exposing (Location)
import UrlParser exposing (..)


type Route
    = MainRoute
    | TransfersRoute String
    | NotFoundRoute

matchers : Parser (Route -> a) a
matchers =
    oneOf
    [ map MainRoute top
    , map TransfersRoute (s "transfers" </> string)
    ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
