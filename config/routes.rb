Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, param: :_username 
  post '/login', to: 'authentication#login'

  resources :users do
    resources :subjects
  end

  resources :subjects do
    resources :topics
  end  
  
  resources :topics do
   resources :videos
  end   

  resources :topics do
    resources :notes
  end   
  
  resources :topics do
    resources :doubts
  end   

  resources :topics do
    resources :quizzes
  end 

  resources :quizzes do
    resources :quiz_questions
  end  
  
  resources :users do 
    resources :user_progresses 
  end  
  

  # post '/topics', to:'topics#create' 
  # get '/topics', to:'topics#index'
  # delete '/topics/:id', to: 'topics#destroy'

  # get '/*a', to: 'application#not_found'
end
