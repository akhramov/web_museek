module View exposing (..)

import Html exposing (Html, div, text, a)
import Html.Attributes exposing (href)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Transfers.List
import Transfers.Models exposing (Transfer)
import Routing exposing (Route(..))

view : Model -> Html Msg
view model =
    div []
        [ nav model
        , page model
        ]


nav : Model -> Html Msg
nav model =
    div []
        [ a [href "#transfers/upload"] [ text "Transfers" ]
        , a [href "#search" ] [ text "" ]
        ]

page : Model -> Html Msg
page model =
    case model.route of
        MainRoute ->
            welcome

        TransfersRoute direction ->
            transfersListView model.transfers direction

        NotFoundRoute ->
            notFoundView

welcome : Html Msg
welcome =
    div [] [text "Hello!"]

notFoundView : Html Msg
notFoundView =
    div [] [text "not found"]

transfersListView : List Transfer -> String -> Html Msg
transfersListView transfers direction =
    let
        isUpload = case direction of
            "download" ->
                Just False
            "upload" ->
                Just True
            _ ->
                Nothing

    in
        case isUpload of
            Just boolean ->
                List.filter (\n -> n.isUpload == boolean) transfers
                    |> Transfers.List.view
                    |> Html.map TransfersMsg

            Nothing ->
                notFoundView
