# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
RedmineApp::Application.routes.draw do
#  resources :copy_projects, :only => [:update]
  get 'users/:id/copy_projects/', :to => 'copy_projects#run'
  get 'users/:id/copy_projects/clear_all', :to => 'copy_projects#clear_all'
end
