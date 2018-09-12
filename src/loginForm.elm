import Browser
import Html exposing (Html, div, input, button, text)
import Html.Attributes exposing (type_, placeholder, value, style)
import Html.Events exposing (onInput, onClick)


-- MAIN
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL
type alias Model =
    { email: String
    , password: String
    , submitted: Bool
    }

init : Model
init =
    Model "" "" False


-- UPDATE
type Msg
  = Email String
  | Password String
  | Submit

update : Msg -> Model -> Model
update msg model =
    case msg of
        Email email ->
            { model | email = email, submitted = False }
        Password password ->
            { model | password = password, submitted = False }
        Submit ->
            { model | submitted = True }


-- VIEW
view : Model -> Html Msg
view model =
    div []
    [ viewInput "email" "joe.doe@github.com" model.email Email
    , viewInput "password" "Password" model.password Password
    , viewValidation model
    , button [ onClick Submit ] [ text "Login" ]
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    div [] [ input [ type_ t, placeholder p, value v, onInput toMsg ] [] ]


viewValidation : Model -> Html msg
viewValidation model =
    if model.submitted == False then
      div [] []
    else if model.email == "joe.doe@github.com" && model.password == "elm" then
      div [ style "color" "green" ] [ text "OK" ]
    else
      div [ style "color" "red" ] [ text "Wrong email or password" ]

