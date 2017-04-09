Rails.application.routes.draw do
  resources :jabatans
  resources :seksis
  resources :bidangs
  resources :ttds
  resources :pendataans do
    collection do
      get 'cetak_sptpd'
      get 'surat_teguran'
      get 'cetak_surat_teguran'
    end
  end
  resources :rekenings do
    collection do 
      get 'update_rekening'
    end 
  end
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
