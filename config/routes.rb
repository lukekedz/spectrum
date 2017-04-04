Rails.application.routes.draw do
  
  root 'site#root'

  get  'site/goals'
  get  'site/assists'
  get  'site/pim'
  get  'site/def'

  get  'site/last_upload'
  get  'site/scrape'
  
  post 'site/stats_upload'

end
