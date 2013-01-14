RailsExample::Application.routes.draw do

  root :to => "users#index"

  resources :users do
    collection do
      get :comufy
    end
  end

end
