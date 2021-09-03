# in routes always set the URL

# sample: use "resources :welcome" to generate url link

Rails.application.routes.draw do
  resources :stocks
  get 'welcome/index'
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

  devise_scope :user do
    authenticated :user do
      namespace :users do
        get 'dashboard/index', as: :authenticated_root
      end
    end
  end
  
  devise_scope :admin do
    authenticated :admin do
      namespace :admins do
        get 'dashboard/index', as: :authenticated_root
        patch 'dashboard/:id/update', to:'dashboard#update', as: :approved
        # used this url in admin-dashboard-index
        # create a route for patch/update
        # "as: :approved" is used to customizing your url link. check admins-dashboard-index for sample view
      end
    end
  end

  root to: 'welcome#index'
end