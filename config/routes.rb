Rails.application.routes.draw do
  get "osusumes/get_novel_info"
  resources :comments
  resources :novels
  resources :osusumes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "osusumes#show"
end
