Rails.application.routes.draw do
  root 'site#scrape'
  post 'site/stats_upload'
  get  'site/last_upload'
end
