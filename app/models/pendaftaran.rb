class Pendaftaran < ApplicationRecord
    include Auditable
    acts_as_paranoid
    belongs_to :kecamatan
    belongs_to :kelurahan
    belongs_to :usaha
    #Validasi
    validates :nama_usaha, :alamat_usaha, :kecamatan_id, :kelurahan_id, :nama_pemilik, :alamat_pemilik, :npwpd, :tgl_npwpd, :usaha_id, :no_reg_pendaftaran, :tgl_npwpd, :tgl_daftar, presence: true
    validates :npwpd, :no_pendaftaran, :no_reg_pendaftaran, uniqueness: true

    #slugger
    extend FriendlyId
    friendly_id :nama_usaha, use: :slugged

    #scope untuk filter like
    scope :like, ->(args) { where("trim(upper(no_pendaftaran)) like trim(upper('%#{args}%')) or trim(upper(npwpd)) like trim(upper('%#{args}%')) or trim(upper(nama_usaha)) like trim(upper('%#{args}%')) or trim(upper(nama_pemilik)) like trim(upper('%#{args}%'))")}

    GOLONGAN = [["1 - Pribadi", "1"], ["2 - Badan", "2"]]

    # before_create do
    #     self.tgl_daftar = Date.today unless self.day
    # end

end
