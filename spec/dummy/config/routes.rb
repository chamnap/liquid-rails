Rails.application.routes.draw do
  root to: 'home#index'
  get  '/index_with_layout',            to: 'home#index_with_layout'
  get  '/index_partial',                to: 'home#index_partial'
  get  '/index_partial_with_full_path', to: 'home#index_partial_with_full_path'
end