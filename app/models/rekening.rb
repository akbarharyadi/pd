class Rekening < ApplicationRecord
    validates :tahun, :kode, :jenis_kode, :turunan_kode, :nama_rekening, presence: true
end
