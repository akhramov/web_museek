module Models exposing (Model, initialModel)

import Transfers.Models exposing (Transfer)
import Routing

type alias Model =
    { transfers : List Transfer
    , route : Routing.Route
    }

initialModel : Routing.Route -> Model
initialModel route =
    { transfers = []
    , route = route
    }
