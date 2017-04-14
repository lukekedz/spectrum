Rails.application.routes.draw do
  
  root 'site#root'

  get  'site/goals'
  get  'site/assists'
  get  'site/pim'
  get  'site/def'
  get  'site/granimation'
  get  'site/ga_goals'

  get  'site/last_upload'
  post 'site/stats_upload'

end
