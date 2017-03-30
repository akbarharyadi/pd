Rails.application.routes.draw do
  resources :rekenings
  resources :pendaftarans do
    collection do
      get 'daftar_wajib_pajak'
    end
  end
  resources :usahas
  resources :wilayahs, only: [:show, :update, :edit, :create]
  devise_for :users
  resources :kelurahans do
    collection do 
      get 'update_kelurahan'
    end 
  end
  resources :kecamatans
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
