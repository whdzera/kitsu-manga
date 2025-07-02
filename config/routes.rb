Rails.application.routes.draw do
  # Profile Users
  get "profiles/show"

  # Devise routes for users
  devise_for :users,
             controllers: {
               registrations: "users/registrations",
               sessions: "users/sessions",
               confirmations: "users/confirmations"
             }

  # Rest APIs
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post "login", to: "sessions#create"
        delete "logout", to: "sessions#destroy"
      end
      resources :mangas, path: "manga", param: :id do
        resources :chapters, param: :chapter_number
      end
    end
  end

  # check username form
  devise_scope :user do
    get "users/check_username", to: "users/registrations#check_username"
  end

  # Static page for confirmation instructions
  get "/confirmation_instructions",
      to: "static_pages#confirmation_instructions",
      as: :confirmation_instructions

  # Homepage accessible to everyone
  root to: "home#index"

  # Announcement
  patch "/announcement", to: "announcements#update", as: :update_announcement

  # 404 page not found
  match "/404", to: "errors#not_found", via: :all

  # user profile
  get "/u/:username", to: "profiles#show", as: :user_profile
  resources :profile_comments, only: %i[create destroy]

  # Admin area
  namespace :admin do
    get "account", to: "dashboard#index"
    patch "profile", to: "dashboard#update", as: :profile_update
    get "usermanagement", to: "dashboard#users_manag"
    get "mangamanagement", to: "dashboard#manga_manag"
    get "apimanagement", to: "dashboard#api"
    get "reports", to: "dashboard#reports", as: "reports"
    get "users/:id/edit", to: "dashboard#edit_user", as: "edit_user"
    patch "users/:id", to: "dashboard#update_user", as: "update_user"
    delete "users/:id", to: "dashboard#delete_user", as: "delete_user"
  end

  # Member area
  namespace :member do
    get "account", to: "dashboard#index"
    patch "profile", to: "dashboard#update", as: :profile_update
  end

  # Search
  get "/search", to: "mangas#search"

  # Bookmarks
  get "/manga/bookmarks", to: "bookmarks#index", as: "manga_bookmarks"

  # Rss Feed
  get "/feed", to: "chapters#feed", defaults: { format: "rss" }

  # List lastest chapters
  get "/manga/chapters", to: "chapters#index", as: "all_manga_chapters"

  # List Genre
  resources :genres, only: %i[create destroy]
  get "/manga/genres", to: "mangas#genres", as: "manga_genres"
  get "/manga/genre/:name", to: "mangas#by_genre", as: "manga_by_genre"

  # manga
  resources :mangas, path: "manga", param: :id do
    resource :bookmark, only: %i[create destroy]
    get "chapter-:chapter_number", to: "chapters#show", as: "chapter"

    # update chapter
    get "chapter-:chapter_number/edit", to: "chapters#edit", as: "edit_chapter"
    patch "chapter-:chapter_number", to: "chapters#update"

    # new chapter
    get "chapter/new", to: "chapters#new", as: "new_chapter"
    post "chapter", to: "chapters#create", as: "chapter_create"

    # delete chapter
    delete "chapter-:chapter_number",
           to: "chapters#destroy",
           as: "delete_chapter"

    # comments
    post "chapter-:chapter_number/comments",
         to: "comments#create",
         as: "chapter_comments"
    delete "chapter-:chapter_number/comments/:id",
           to: "comments#destroy",
           as: "chapter_comment"
  end
end
