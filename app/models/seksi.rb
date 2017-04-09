class Seksi < ApplicationRecord
    include Auditable
    belongs_to :bidang
    
    #Validasi kode
    validates :kode_seksi, :nama_seksi, :bidang_id, presence: true
    validates :kode_seksi, uniqueness: true
    validates :kode_seksi, length: { minimum:2 }


    #slugger
    extend FriendlyId
    friendly_id :nama_seksi, use: :slugged

    #scope untuk filter like
    scope :like, ->(args) { where("trim(upper(kode_seksi)) like trim(upper('%#{args}%')) or trim(upper(nama_seksi)) like trim(upper('%#{args}%')) or trim(upper(singkatan)) like trim(upper('%#{args}%')) or trim(upper(bidangs.nama_bidang)) like trim(upper('%#{args}%'))")}
    #select kode dan nama
    def kode_dan_seksi
        "#{kode_seksi} - #{nama_seksi}"
    end
end
