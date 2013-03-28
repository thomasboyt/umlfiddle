Umlfiddle::Application.routes.draw do
  resources :fiddles do
    resources :revisions, :path => 'v'
  end

  match "/" => "fiddles#new"
end
