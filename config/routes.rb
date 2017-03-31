Rails.application.routes.draw do
  root 'site#last_upload'
  get  'site/scrape'
  post 'site/stats_upload'
end
