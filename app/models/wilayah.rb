class Wilayah < ApplicationRecord
    # #slugger
    # extend FriendlyId
    # friendly_id :nama_wilayah, use: :slugged

    #Validasi nama wilayah
    validates :nama_wilayah, :jenis_wilayah, :pemimpin, :ibu_kota, :nama_badan, :alamat_badan, :telp_badan, presence: { message: " tidak boleh kosong" }

end
