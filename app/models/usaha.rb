class Usaha < ApplicationRecord
    include Auditable
    has_many :pendaftaran
    #Validasi
    validates :kode_usaha, :nama_usaha, presence: { message: " tidak boleh kosong" }
    validates :kode_usaha, uniqueness: { message: " tidak boleh sama" }
    validates :kode_usaha, length: { minimum:2,   message: " harus 2 angka" }

    #slugger
    extend FriendlyId
    friendly_id :nama_usaha, use: :slugged

    #scope untuk filter like
    scope :like, ->(args) { where("trim(upper(kode_usaha)) like trim(upper('%#{args}%')) or trim(upper(nama_usaha)) like trim(upper('%#{args}%'))")}

    def kode_dan_usaha
        "#{kode_usaha} - #{nama_usaha}"
    end
end
