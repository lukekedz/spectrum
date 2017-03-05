Rails.application.routes.draw do
  root 'site#scrape'
  post 'site/stats_upload'

  devise_for :users

end
