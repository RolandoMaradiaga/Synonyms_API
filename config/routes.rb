Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :words, only: [] do
    collection do
      get ':text/synonyms', to: 'words#synonyms', as: 'word_synonyms'
    end
  end
  resources :synonyms, only: [:create, :index, :destroy] do
    member do
      post 'approve' # Defines route for approving a synonym
    end
  end

end
