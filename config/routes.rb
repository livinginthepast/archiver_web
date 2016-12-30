Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :auth do
    get '/google/callback', to: 'auth/google#callback'
    post '/developer/callback', to: 'auth/developer#callback' if Rails.env.development?

    delete '/', to: 'auth/sessions#delete'
    get '/sign_out', to: 'auth/sessions#delete'
    get '/sign_in', to: 'auth/sessions#new', as: :sign_in
  end

  root to: 'things#index'
end
