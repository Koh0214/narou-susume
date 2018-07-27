Rails.application.routes.draw do
  get "osusumes/get_novel_info"
  get "osusumes/like"
  get "novels/comment_count_up"
  get "novels/comment_count_down"
  resources :comments
  resources :novels
  resources :osusumes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "osusumes#index"
end
