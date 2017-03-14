Rails.application.routes.draw do
  # root 'site#scrape'
  post 'site/stats_upload'
  # get  'site/last_upload'
  root 'site#last_upload'

  # devise_for :users
end
