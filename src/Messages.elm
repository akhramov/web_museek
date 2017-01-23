module Messages exposing (..)

import Navigation exposing (Location)
import Transfers.Messages

type Msg
    = TransfersMsg Transfers.Messages.Msg
    | OnLocationChange Location
