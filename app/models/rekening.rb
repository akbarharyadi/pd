class Rekening < ApplicationRecord

    has_many :rekening
    validates :tahun, :kode, :jenis_kode, :turunan_kode, :nama_rekening, presence: true

    #slugger
    extend FriendlyId
    friendly_id :nama_rekening, use: :slugged

    def kode_dan_nama_rekening
        "#{kode} - #{nama_rekening}"
    end

    def rekenig_lengkap
        "4.#{kode}.#{jenis_kode}.#{turunan_kode}"
    end

    def rekenig_lengkap_dan_nama
        "4.#{kode}.#{jenis_kode}.#{turunan_kode} - #{nama_rekening}"
    end
end
