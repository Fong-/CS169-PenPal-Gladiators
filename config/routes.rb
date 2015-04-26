CS169PenpalGladiators::Application.routes.draw do
    mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
    get "/api/v1/topics" => "topics#get_all"
    get "/api/v1/topic/:id" => "topics#get_by_id"
    get "/api/v1/topic/:id/survey_questions" => "topics#get_questions_by_id"
    post "/api/v1/login" => "users#login"
    post "/api/v1/register" => "users#register"
    get "/api/v1/register" => "users#can_register"
    get "/api/v1/authenticate" => "users#authenticate"
    get "/api/v1/survey_questions" => "survey_questions#get_all"
    get "/api/v1/survey_question/:id" => "survey_questions#get_by_id"
    get "/api/v1/survey_question/:id/survey_responses" => "survey_questions#get_responses_by_id"
    get "/api/v1/survey_responses" => "survey_responses#get_all"
    get "/api/v1/survey_response/:id" => "survey_responses#get_by_id"
    get "/api/v1/user/:id/profile" => "users#get_profile_info_by_id"
    post "/api/v1/user/:id/profile" => "users#post_profile_info_by_id"
    get "/api/v1/arenas/:user_id" => "arenas#get_by_user_id"
    get "/api/v1/conversation/:id" => "conversations#get_by_id"
    post "/api/v1/conversation/create/:user_id" => "conversations#create"
    post "/api/v1/post/create/:conversation_id" => "posts#create"
    post "/api/v1/post/edit/:post_id" => "posts#edit"
    # Public routes
    get "/" => "pages#homepage"
    get "/login" => "pages#startpage"

    # The priority is based upon order of creation:
    # first created -> highest priority.

    # Sample of regular route:
    #   match 'products/:id' => 'catalog#view'
    # Keep in mind you can assign values other than :controller and :action

    # Sample of named route:
    #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
    # This route can be invoked with purchase_url(:id => product.id)

    # Sample resource route (maps HTTP verbs to controller actions automatically):
    #   resources :products

    # Sample resource route with options:
    #   resources :products do
    #     member do
    #       get 'short'
    #       post 'toggle'
    #     end
    #
    #     collection do
    #       get 'sold'
    #     end
    #   end

    # Sample resource route with sub-resources:
    #   resources :products do
    #     resources :comments, :sales
    #     resource :seller
    #   end

    # Sample resource route with more complex sub-resources
    #   resources :products do
    #     resources :comments
    #     resources :sales do
    #       get 'recent', :on => :collection
    #     end
    #   end

    # Sample resource route within a namespace:
    #   namespace :admin do
    #     # Directs /admin/products/* to Admin::ProductsController
    #     # (app/controllers/admin/products_controller.rb)
    #     resources :products
    #   end

    # You can have the root of your site routed with "root"
    # just remember to delete public/index.html.
    # root :to => 'welcome#index'

    # See how all your routes lay out with "rake routes"

    # This is a legacy wild controller route that's not recommended for RESTful applications.
    # Note: This route will make all actions in every controller accessible via GET requests.
    # match ':controller(/:action(/:id))(.:format)'
end
