# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
RedmineApp::Application.routes.draw do
#  resources :copy_projects, :only => [:update]
  match 'users/:id/copy_projects/', :to => 'copy_projects#copy_projects', :via => :get, :as => :copy_projects
end
