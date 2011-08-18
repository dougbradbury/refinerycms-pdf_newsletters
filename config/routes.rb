::Refinery::Application.routes.draw do
  resources :pdf_newsletters, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :pdf_newsletters, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
