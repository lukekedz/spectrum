Rails.application.routes.draw do
  get  'site/last_upload'
  root 'site#scrape'
  post 'site/stats_upload'
end
