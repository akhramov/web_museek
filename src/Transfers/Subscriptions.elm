module Transfers.Subscriptions exposing (..)

import Transfers.Models exposing (Transfer, transferMessageDecoder)
import Transfers.Messages exposing (Msg(..))
import Json.Decode
import WebSocket

subscriptions : Sub Msg
subscriptions =
    WebSocket.listen "ws://localhost:9292" decodeTransfer


decodeTransfer : String -> Msg
decodeTransfer string =
    let
        result = string
               |> Json.Decode.decodeString transferMessageDecoder

    in
        case result of
            Ok transfer ->
                NewTransfer transfer

            Err reason ->
                TransferError "Error during parsing transfer"
