class Pegawai < ApplicationRecord
    include Auditable
    belongs_to :bidang
    belongs_to :seksi
    belongs_to :jabatan
    belongs_to :golongan
    has_many :ttd
    
    #Validasi kode
    validates :nama_pegawai, :nip, :jabatan_id, presence: true
    validates :jabatan_id, :nip, uniqueness: true


    #slugger
    extend FriendlyId
    friendly_id :nama_pegawai, use: :slugged

    #scope untuk filter like
    scope :like, ->(args) { where("trim(upper(nip)) like trim(upper('%#{args}%')) or trim(upper(nama_pegawai)) like trim(upper('%#{args}%'))")}
    #select kode dan nama
    def nip_dan_nama
        "#{nip} - #{nama_pegawai}"
    end
end
