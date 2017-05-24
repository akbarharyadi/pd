Rails.application.routes.draw do
  resources :pegawais
  resources :golongans
  resources :jabatans
  resources :seksis do
    collection do
      get 'update_seksi'
    end
  end
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
      match 'cetak_npwpd', via: [:get, :post]
      match 'cetak_kartu_data', via: [:get, :post]
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

  get 'penyetoran/index'
  get 'penyetoran/proses'
  get 'penyetoran/list'
  match 'penyetoran/cetak_sts', via: [:get, :post]
  get 'penyetoran/cetak_tanda_bukti'

  match 'penetapan/index', via: [:get, :post]
  post 'penetapan/tetapkan'
  get 'penetapan/proses'
  get 'penetapan/list'
  match 'penetapan/cetak_skp', via: [:get, :post]
  
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
