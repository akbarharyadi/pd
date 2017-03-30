class Kecamatan < ApplicationRecord
    include Auditable
    has_many :kelurahan, :dependent => :destroy
    has_many :pendaftaran
    
    #Validasi kode
    validates :kode, :nama, presence: true
    validates :kode, uniqueness: true
    validates :kode, length: { minimum:2 }


    #slugger
    extend FriendlyId
    friendly_id :nama, use: :slugged

    #scope untuk filter like
    scope :like, ->(args) { where("trim(upper(kode)) like trim(upper('%#{args}%')) or trim(upper(nama)) like trim(upper('%#{args}%'))")}
    #select kode dan nama
    def kode_dan_kecamatan
        "#{kode} - #{nama}"
    end
end
