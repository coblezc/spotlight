Spotlight::Engine.routes.draw do
  resources :attachments
  resource :contact_form, only: [:new, :create]

  resources :exhibits, only: [:edit, :update] do
    resource :blacklight_configuration, only: [:update]

    get 'edit/metadata', to: "blacklight_configurations#edit_metadata_fields"
    get 'edit/facets', to: "blacklight_configurations#edit_facet_fields"

    resources :catalog, only: [:index, :show, :edit, :update] do
      collection do
        get 'admin'
      end
    end

    resources :custom_fields, shallow: true

    resources :searches, shallow: true do
      collection do
        patch :update_all
      end
    end
    resources :browse, only: [:index, :show]
    resources :tags, only: [:index, :destroy]

    resources :about, controller: "about_pages", as: "about_pages", shallow: true do
      collection do
        patch :update_all
      end
    end
    resources :feature, controller: "feature_pages", as: "feature_pages", shallow: true do
      collection do
        patch :update_all
      end
    end
    resources :home_page, controller: "home_pages", as: "home_pages", shallow: true

    resources :roles, only: [:index, :create, :destroy] do
      collection do
        patch :update_all
      end
    end
  end
end
