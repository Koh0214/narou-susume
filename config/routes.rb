Rails.application.routes.draw do
  resources :osusumes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "application#root"
end
