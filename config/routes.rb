Todo::Application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }  

  namespace :api, defaults: {format: :json} do
    devise_scope :user do
      resource :session, only: [:create, :destroy]
    end
    resources :task_lists, only: [:index, :create, :update, :destroy, :show] do
      resources :tasks, only: [:index, :create, :update, :destroy, :show] do
        resources :comments, only: [:index, :create, :update, :destroy]
      end
    end
  end

  root :to => "home#index"

  get '/dashboard' => 'templates#index'
  get '/task_lists/:id' => 'templates#index'
  get '/task_lists/:list_id/tasks/:id' => 'templates#index'
  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/  }
  post '/uploads' => 'uploads#index'
end
