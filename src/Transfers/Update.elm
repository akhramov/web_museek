module Transfers.Update exposing (update)

import Transfers.Messages exposing (Msg(..))
import Transfers.Models exposing (Transfer)
import Navigation

update : Msg -> List Transfer -> (List Transfer, Cmd Msg)
update message transfers =
    case message of
        NewTransfer transfer ->
            (uniqPush transfer transfers, Cmd.none)

        TransferError reason ->
            (transfers, Cmd.none)

uniqPush : Transfer -> List Transfer -> List Transfer
uniqPush transfer transfers =
    let
        oldTransferEntry : Transfer -> Bool
        oldTransferEntry n =
            (n.path, n.user, n.isUpload) /= (transfer.path, transfer.user, transfer.isUpload)

    in
        transfer :: (List.filter oldTransferEntry transfers)
