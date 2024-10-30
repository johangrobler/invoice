Rails.application.routes.draw do
  resources :messages
  get "dashboard/index"
  get "home/index"
  get "about" , to: "home#about"
  get "pricing" , to: "home#pricing"
  get "contact" , to: "home#contact"
  get "dashboard" , to: "dashboard#index"
 
  devise_for :users
  resources :items
  resources :invoices
  resources :customers
  resources :companies
  resources :banks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
  
  get 'invoices/:id/download', to: 'invoices#download_pdf', as: 'download_pdf'
  
  # send_invoice_email
  get 'invoices/:id/send_invoice_email', to: 'invoices#send_invoice_email', as: 'send_invoice_email'

end
