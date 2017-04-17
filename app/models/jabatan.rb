class Jabatan < ApplicationRecord
    include Auditable
    has_many :pegawai
    #Validasi
    validates :kode_jabatan, :nama_jabatan, presence: true
    validates :kode_jabatan, uniqueness: true
    validates :kode_jabatan, length: { minimum:2 }


    #slugger
    extend FriendlyId
    friendly_id :nama_jabatan, use: :slugged

    #scope untuk filter like
    scope :like, ->(args) { where("trim(upper(kode_jabatan)) like trim(upper('%#{args}%')) or trim(upper(nama_jabatan)) like trim(upper('%#{args}%')) or trim(upper(singkatan)) like trim(upper('%#{args}%'))")}
    #select kode dan nama
    def kode_dan_jabatan
        "#{kode_jabatan} - #{nama_jabatan}"
    end
end
