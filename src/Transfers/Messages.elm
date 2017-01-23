module Transfers.Messages exposing (Msg(..))

import Transfers.Models exposing (Transfer)

type Msg
    = NewTransfer Transfer
    | TransferError String
