class Ttd < ApplicationRecord
    include Auditable
    belongs_to :pegawai
    #Validasi kode
    validates :nama_surat, presence: true


    #slugger
    extend FriendlyId
    friendly_id :nama_surat, use: :slugged

    #scope untuk filter like
    scope :like, ->(args) { where("trim(upper(nama_surat)) like trim(upper('%#{args}%')) or trim(upper(baris1)) like trim(upper('%#{args}%')) or trim(upper(baris2)) like trim(upper('%#{args}%')) or trim(upper(baris3)) like trim(upper('%#{args}%'))")}
    #select kode dan nama

end
