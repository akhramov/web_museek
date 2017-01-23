module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (parseLocation)

import Transfers.Update

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        OnLocationChange location ->
            ({ model | route = (parseLocation location) }, Cmd.none)

        TransfersMsg subMsg ->
            let
                (updatedTransfers, cmd) =
                    Transfers.Update.update subMsg model.transfers
            in
                ({ model | transfers = updatedTransfers }, Cmd.map TransfersMsg cmd)
