Datajam::Application.routes.draw do

  namespace :api do
    resources :meter_reads, only: [ :index ]
  end
  root to: 'pages#home'

end
