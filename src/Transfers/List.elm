module Transfers.List exposing (view)

import Html exposing (..)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Regex exposing (regex, split, HowMany(..))
import List.Extra exposing (..)

import Transfers.Messages exposing (Msg(..))
import Transfers.Models exposing (Transfer)


view : List Transfer -> Html Msg
view transfers =
    div []
        [ ul [] [ navItem ("#transfers/download", "Downloads")
                , navItem ("#transfers/upload", "Uploads")
                ]
        , table []
              [ thead []
                    [ tr []
                          [ th [] [ text "User" ]
                          , th [] [ text "Path" ]
                          , th [] [ text "File" ]
                          , th [] [ text "State" ]
                          , th [] [ text "Progress" ]
                          , th [] [ text "File Size" ]
                          , th [] [ text "Rate" ]
                          , th [] [ text "Place" ]
                          ]
                    ]
              , List.sortBy .path transfers |> presentTransfers |> tbody []
              ]
        ]


navItem : (String, String) -> Html Msg
navItem (link, name) =
    li [] [ a [ href link ] [ text name ] ]


transferRow : Transfer -> Html Msg
transferRow transfer =
    tr []
        [ td [] []
        , td [] []
        , td [] [ text <| (.path >> baseName) transfer ]
        , td [] [ text transfer.state ]
        , td [] [ text <| toString transfer.progress ]
        , td [] [ text <| toString transfer.fileSize ]
        , td [] [ text <| toString transfer.rate ]
        , td [] [ text <| toString transfer.place ]
        ]


presentTransfers : List Transfer -> List (Html Msg)
presentTransfers transfers =
    List.sortBy .user transfers
        |> presentUserTransfers 0 [.user, .path >> dirName]

dirName : String -> String
dirName path =
    case splitPath path |> init of
        Just dirname -> String.join "/" dirname
        Nothing -> "root"

baseName : String -> String
baseName path =
    case splitPath path |> last of
        Just string -> string
        Nothing -> "file"

splitPath : String -> List String
splitPath path =
    String.split "\\" path


presentUserTransfers : Int -> List (Transfer -> String) -> List Transfer -> List (Html Msg)
presentUserTransfers n fields transfers =
    case fields of
        field::ftail ->
            let
                list = groupWhile (\x y -> field x == field y) transfers
            in
                List.concatMap (\list ->
                                    case list of
                                        head::tail ->
                                            tr [] (List.repeat n (td [] []) ++  [ td [] [ text (field head) ] ]) ::
                                                presentUserTransfers (n + 1) ftail list

                                        [] -> []
                               ) list

        [] -> List.map transferRow transfers
