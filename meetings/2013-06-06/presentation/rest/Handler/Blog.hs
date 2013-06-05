module Handler.Blog (
       getBlogR
      ,postBlogR
) where

import Import

import Yesod.Form.Nic (YesodNic, nicHtmlField)
-- |najlepiej dac ta linijke w Foundation.hs
instance YesodNic App

-- |form do dodawania nowego artykulu
-- areq - wymagany input dla forma
-- areq <type> <label> <default_value>
entryForm :: Form Article
entryForm = renderDivs $ Article
          <$> areq textField "Title" Nothing
          <*> areq nicHtmlField "Content" Nothing

getBlogR :: Handler Html
getBlogR = do
         -- |lista artykulow z DB
         articles <- runDB $ selectList [] [Desc ArticleTitle]
         (articleWidget, enctype) <- generateFormPost entryForm
         defaultLayout $(widgetFile "articles")

postBlogR :: Handler Html
postBlogR = do
              ((res, articleWidget), enctype) <- runFormPost entryForm
              case res of
                   FormSuccess article -> do
                                       articleId <- runDB $ insert article
                                       setMessage $ toHtml $ (articleTitle article) <> "created"
                                       redirect $ ArticleR articleId
                   _                   -> defaultLayout $ do
                                               setTitle "Please correct your entry form"
                                               $(widgetFile "articleError")
