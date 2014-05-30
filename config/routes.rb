Styled::Engine.routes.draw do
  unless Rails.env.production?
    root "guides#index"

    get "guides"       => "guides#index", as: "guides"
    get "guides/*id"   => "guides#show",  as: "guide"

    get "docs", to: redirect("docs/home/index.html")
    get "docs/home/index"    => "docs#show", page: "index"

    get "docs(/*path)/index" => "docs#show", page: "index", as: "doc"
    get "docs(/*path)"       => "docs#show"
  end
end
