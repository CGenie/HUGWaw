module Handler.Shakespeare where

import Import

getShakespeareR :: Handler Html
getShakespeareR = do
                defaultLayout $ do
                              toWidget [cassius|
h2
    color: green|]
                              -- |add another file, Lucius this time
                              toWidget ($(widgetFile "shakespeare2") :: Widget)

                              -- |some external JavaScript
                              addScriptRemote "http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"

                              -- |some inline JavaScript
                              toWidget [julius|
    $(document).ready(function() {
        $("h3").first().after("<h4>The Slings and Arrows of outrageous Fortune,</h4>");
        var $elem = $("h4").first();

        var blink = function() {
            $elem.fadeTo("slow", 0).fadeTo("slow", 1);

            setTimeout(blink, 2000);
        }

        blink();
    })
|]

                              -- |shakespeare.cassius, shakespeare.julius files are added automatically
                              $(widgetFile "shakespeare")
