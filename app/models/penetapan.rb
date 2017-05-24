class Penetapan < ApplicationRecord
    belongs_to :pendataan

    enum status: {sptpd:0, skpd:1, skpdkb:2, skpdn:3, belum_penetapan:4}
    enum status2: {skpd_:1, skpdkb_:2, skpdn_:3}

    validates :no_tetap, :pendataan_id, presence: true

    attr_accessor :tarif_persen_teliti, :tarif_rupiah_teliti

    scope :like, ->(args) { where("pendataans.tahun_spt::text= '#{args}' or pendataans.no_pendataan= '#{args}' or trim(upper(rekenings.nama_rekening)) like trim(upper('%#{args}%')) or trim(upper(pendaftarans.npwp)) like trim(upper('%#{args}%')) or trim(upper(pendaftarans.nama_usaha)) like trim(upper('%#{args}%')) or no_tetap=#{args} or no_setor=#{args}")}
end
