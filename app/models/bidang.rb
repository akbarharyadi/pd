class Bidang < ApplicationRecord
    include Auditable
    has_many :seksi
    
    #Validasi kode
    validates :kode_bidang, :nama_bidang, presence: true
    validates :kode_bidang, uniqueness: true
    validates :kode_bidang, length: { minimum:2 }


    #slugger
    extend FriendlyId
    friendly_id :nama_bidang, use: :slugged

    #scope untuk filter like
    scope :like, ->(args) { where("trim(upper(kode_bidang)) like trim(upper('%#{args}%')) or trim(upper(nama_bidang)) like trim(upper('%#{args}%'))")}
    #select kode dan nama
    def kode_dan_bidang
        "#{kode_bidang} - #{nama_bidang}"
    end
end
