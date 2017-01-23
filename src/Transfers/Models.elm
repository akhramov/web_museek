module Transfers.Models exposing (..)

import Json.Decode exposing (int, bool, string, Decoder)
import Json.Decode.Pipeline exposing (decode, required)

type alias Transfer =
    { isUpload : Bool
    , state : String
    , fileSize : Int
    , progress : Int
    , user : String
    , rate : Int
    , path : String
    , place : Int
    }

transferMessageDecoder : Decoder Transfer
transferMessageDecoder =
    decode Transfer
        |> required "upload" bool
        |> required "state" string
        |> required "filesize" int
        |> required "progress" int
        |> required "user" string
        |> required "rate" int
        |> required "path" string
        |> required "place" int
