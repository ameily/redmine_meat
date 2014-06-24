Redmine::Plugin.register :meat do
  name 'Meat plugin'
  author 'Adam Meily'
  description 'Fires MEAT digestable events'
  version '0.0.1'
  url 'https://github.com/ameily/redmine_meat'
  author_url 'https://github.com/ameily'

  settings :default => { 'url' => '' }, :partial => 'settings/meat_settings'

end
