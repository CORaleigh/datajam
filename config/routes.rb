Datajam::Application.routes.draw do

  namespace :api do
    resources :meter_reads, only: [ :index, :create ]
  end
  root to: 'pages#home'

end
