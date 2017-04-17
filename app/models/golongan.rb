class Golongan < ApplicationRecord
    include Auditable
    has_many :pegawai
    #Validasi kode
    validates :golongan, :ruang, :nama_pangkat, presence: true


    #slugger
    extend FriendlyId
    friendly_id :nama_pangkat, use: :slugged

    #scope untuk filter like
    scope :like, ->(args) { where("trim(upper(golongan)) like trim(upper('%#{args}%')) or trim(upper(ruang)) like trim(upper('%#{args}%')) or trim(upper(nama_pangkat)) like trim(upper('%#{args}%'))")}
    #select kode dan nama
    def kode_dan_golongan
        "#{nama_pangkat} #{ruang}/#{golongan}"
    end
end
