Rails.application.routes.draw do
  # root 'site#root'

  root 'site#static_chartkick'
  get 'site/static_chartkick_modal'

  # get  'site/single_page_app'
  # get  'site/goals'
  # get  'site/assists'
  # get  'site/pim'
  # get  'site/def'
  # get  'site/granimation'
  # get  'site/ga_goals'

  get  'site/last_upload'
  post 'site/stats_upload'
  get  'site/last_twelve'
end
