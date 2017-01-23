module Subscriptions exposing (..)

import Transfers.Subscriptions
import Models exposing (Model)
import Messages exposing (Msg(..))

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map TransfersMsg Transfers.Subscriptions.subscriptions
        ]
