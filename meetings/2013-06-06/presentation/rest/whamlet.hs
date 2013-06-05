page = [hamlet|
<p>Page content
^{footer}
|]

footer = [hamlet|
<footer>
    <p>Copyright
|]

-- Zwrocmy uwage na to ze ^{footer} w kodzie dla page to include szablonu Hamleta



-- A co jak do footera dodamy styl?

footer = do
    toWidget [lucius|footer {font-weight: bold; text-align: center }|]
    toWidget [hamlet|
<footer>
    <p>Copyright
|]

-- Ale Hamlet nie wie nic o widgetach i kod dla page nam sie nie skompiluje...
-- ... wkracza whamlet -- ^{...} pobiera WIDGET a nie szablon Hamlet
page = [whamlet|
<p>Page content
^{footer}
|]