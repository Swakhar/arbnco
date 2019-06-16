Rails.application.routes.draw do
  resources :official_documents, only: %i(index new create show)

  root to: 'official_documents#index'
end
