Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :auth do
    get '/google/callback', to: 'auth/google#callback'
    post '/developer/callback', to: 'auth/developer#callback' if Rails.env.development?

    delete '/', to: 'auth/sessions#delete'
    get '/sign_out', to: 'auth/sessions#delete'
    get '/sign_in', to: 'auth/sessions#new', as: :sign_in
  end

  resources :things, except: [:new]

  get 'settings', to: 'settings#show', as: :settings

  scope :integrations do
    scope :s3 do
      get '/presign', to: 'integrations/s3/images#presign', as: :s3_presign_url
    end
  end

  root to: 'things#index'
end
