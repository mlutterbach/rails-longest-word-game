Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'score', to: 'games#score'
  get 'new', to: 'games#new'
end
